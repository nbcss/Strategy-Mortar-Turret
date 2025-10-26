local cooldown_control = {}

---@class (exact) CooldownTurret
---@field entity LuaEntity
---@field end_tick uint32

function cooldown_control.on_init()
    ---@type table<uint32, uint64[]>
    storage.cooldown_updates = storage.cooldown_updates or {}
    ---@type table<uint64, CooldownTurret>
    storage.cooldown_turrets = storage.cooldown_turrets or {}
end

---@param event EventData.on_tick
function cooldown_control.on_tick(event)
    local tasks = storage.cooldown_updates[event.tick]
    if not tasks then return end
    storage.cooldown_updates[event.tick] = nil
    for _, task in ipairs(tasks) do
        cooldown_control.reenable(task)
    end
end

---@param event EventData.on_entity_cloned
function cooldown_control.on_entity_cloned(event)
    local source = storage.cooldown_turrets[event.source.unit_number--[[@as uint64]]]
    if not source then return end

    ---@type CooldownTurret
    local destination = {
        entity = event.destination,
        end_tick = source.end_tick,
    }
    storage.cooldown_turrets[event.destination.unit_number] = destination

    local tasks = storage.cooldown_updates[source.end_tick]
    table.insert(tasks, destination.entity.unit_number)
end

---@param length uint32
---@param entity LuaEntity
function cooldown_control.apply(length, entity)
    if length <= 0 then return end
    if entity.disabled_by_script then return end

    local end_tick = game.tick + length
    entity.disabled_by_script = true
    storage.cooldown_turrets[entity.unit_number] = {
        entity = entity,
        end_tick = end_tick,
    }

    local tasks = storage.cooldown_updates[end_tick]
    if not tasks then
        tasks = {}
        storage.cooldown_updates[end_tick] = tasks
    end
    table.insert(tasks, entity.unit_number)
end

---@package
function cooldown_control.reenable(unit_number)
    local cooldown_turret = storage.cooldown_turrets[unit_number]
    if not cooldown_turret then return end
    storage.cooldown_turrets[unit_number] = nil

    if not cooldown_turret.entity.valid then return end

    task.entity.disabled_by_script = false
end

return cooldown_control