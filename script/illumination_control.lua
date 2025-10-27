local illumination_control = {}

function illumination_control.on_init()
    storage.illuminated_entities = {}
end

function illumination_control.on_tick(event)
    if event.tick % 60 ~= 0 then return end
    for key, illuminated_entity in pairs(storage.illuminated_entities) do
        if event.tick - illuminated_entity.last_update > 60 then
            storage.illuminated_entities[key] = nil
        end
    end
end

---@param cause_entity LuaEntity turret
---@param source_entity LuaEntity illumination effect (Light)
---@param target_entity LuaEntity target
function illumination_control.apply(cause_entity, source_entity, target_entity)
    if not target_entity or not target_entity.valid then
        return
    end
    if target_entity.force.name == "enemy" and target_entity.is_entity_with_health then
        if storage.illuminated_entities[target_entity.unit_number] then
            local damage = storage.illuminated_entities[target_entity.unit_number].last_health - target_entity.health
            -- deal additional damage in dark environment (10% to 30% of original damage)
            local modifier = 0.1 + target_entity.surface.darkness * 0.2
            if damage > 0 then
                local force = "player"
                if cause_entity and cause_entity.valid then
                    force = cause_entity.force.name
                elseif source_entity and source_entity.valid then
                    force = source_entity.force.name
                end
                target_entity.damage(damage * modifier, force, "illumination", source_entity, cause_entity)
            end
        end
        -- could be invalid (kill by illumination damage)
        if target_entity.valid then
            -- get_damage_to_be_taken() not working :(
            storage.illuminated_entities[target_entity.unit_number] = {
                last_health = target_entity.health,
                last_update = game.tick,
            }
        end
    end
end

return illumination_control