local cooldown_control = {}

local function invoke(task)
    if task.entity.valid then
        task.entity.disabled_by_script = false
    end
end

function cooldown_control.on_init()
    if not storage.cooldown_updates then
        storage.cooldown_updates = {}
    end
end

function cooldown_control.on_tick(event)
    local tasks = storage.cooldown_updates[event.tick]
    if not tasks then return end
    storage.cooldown_updates[event.tick] = nil

    for _, task in ipairs(tasks) do
        invoke(task)
    end
end

function cooldown_control.add(at_tick, turret_entity)
    --todo
    local task = {
        entity = turret_entity
    }
    if at_tick <= game.tick then
        invoke(task)
        return
    end
    local tasks = storage.cooldown_updates[at_tick]
    if not tasks then
        tasks = {}
        storage.cooldown_updates[at_tick] = tasks
    end
    table.insert(tasks, task)
end

return cooldown_control