local hypnosis_control = {}

hypnosis_control.max_chance = 0.25
hypnosis_control.hypnosis_time = 30         -- in seconds
hypnosis_control.transform_coefficient = 15 -- equivalent to damage

function hypnosis_control.apply_effect(cause_entity, source_entity, target_entity)
    local force = "player"
    if cause_entity and cause_entity.valid then
        force = cause_entity.force.name
    elseif source_entity and source_entity.valid then
        force = source_entity.force.name
    end
    local tech_modifer = 1.0 + game.forces[force].get_ammo_damage_modifier("mortar-hypnosis-effect")
    if not target_entity or not target_entity.valid or target_entity.type ~= "unit" then return end
    local chance = math.min(hypnosis_control.max_chance, tech_modifer * hypnosis_control.transform_coefficient / target_entity.max_health)
    if math.random() < chance then
        target_entity.force = force
        target_entity.surface.create_entity { name = "hypnosis-sticker", position = target_entity.position, target = target_entity }
        if target_entity.commandable then
            target_entity.commandable.set_command {
                type = defines.command.wander,
            }
        end
    end
end

return hypnosis_control
