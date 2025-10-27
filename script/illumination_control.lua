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

---@param source LuaEntity
---@param target LuaEntity
function illumination_control.apply(source, target)
    if not target or not target.valid then
        return
    end
    if target.force.name == "enemy" and target.is_entity_with_health then
        if storage.illuminated_entities[target.unit_number] then
            local damage = storage.illuminated_entities[target.unit_number].last_health - target.health
            -- deal additional damage in dark environment (10% to 30% of original damage)
            local modifier = 0.1 + target.surface.darkness * 0.2
            if damage > 0 then
                target.damage(damage * modifier, source.force.name, "illumination", nil, source)
            end
        end
        -- could be invalid (kill by illumination damage)
        if target.valid then
            -- get_damage_to_be_taken() not working :(
            storage.illuminated_entities[target.unit_number] = {
                last_health = target.health,
                last_update = game.tick,
            }
        end
    end
end

return illumination_control