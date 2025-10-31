local bonus_damage_control = {}

function bonus_damage_control.on_init()
    storage.targeted_entities = {}
end

function bonus_damage_control.on_tick(event)
    if event.tick % 60 ~= 0 then return end
    for key, entity in pairs(storage.targeted_entities) do
        if event.tick - entity.last_update > 60 then
            storage.targeted_entities[key] = nil
        end
    end
end

---@param cause_entity LuaEntity turret
---@param source_entity LuaEntity effect trigger
---@param target_entity LuaEntity target
function bonus_damage_control.apply(damage_name, damage_modifer, cause_entity, source_entity, target_entity)
    if not target_entity or not target_entity.valid or not target_entity.unit_number then
        return
    end
    local force = "player"
    if cause_entity and cause_entity.valid then
        force = cause_entity.force.name
    elseif source_entity and source_entity.valid then
        force = source_entity.force.name
    end
    if target_entity.force.name ~= force and target_entity.is_entity_with_health then
        if storage.targeted_entities[target_entity.unit_number] then
            local damage = storage.targeted_entities[target_entity.unit_number].last_health - target_entity.health
            if damage > 0 then
                target_entity.damage(damage * damage_modifer, force, damage_name, source_entity, cause_entity)
            end
        end
        -- could be invalid (kill by bonus damage)
        if target_entity.valid then
            -- get_damage_to_be_taken() not working :(
            storage.targeted_entities[target_entity.unit_number] = {
                last_health = target_entity.health,
                last_update = game.tick,
            }
        end
    end
end

return bonus_damage_control
