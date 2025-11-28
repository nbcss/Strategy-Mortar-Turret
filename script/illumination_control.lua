local bonus_damage_control = require("script.bonus_damage_control")
local illumination_control = {}

illumination_control.base_damage_bonus = 0.05
illumination_control.darkness_damage_bonus = 0.25

function illumination_control.update_entity_damage(cause_entity, source_entity, target_entity)
    if target_entity and target_entity.valid then
        local force = "player"
        if cause_entity and cause_entity.valid then
            force = cause_entity.force.name
        elseif source_entity and source_entity.valid then
            force = source_entity.force.name
        end
        local tech_modifer = 1.0 + game.forces[force].get_ammo_damage_modifier("mortar-illumination-effect")
        -- deal additional damage in dark environment
        local modifier = illumination_control.base_damage_bonus + target_entity.surface.darkness * illumination_control.darkness_damage_bonus
        bonus_damage_control.apply("illumination", modifier * tech_modifer, cause_entity, source_entity, target_entity)
    end
end

return illumination_control
