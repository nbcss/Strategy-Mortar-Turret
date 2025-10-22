local constants = require("constants")

-- update turret parameters
local mortar_turret_entity = data.raw["ammo-turret"]["mortar-turret"]
mortar_turret_entity.attack_parameters.lead_target_for_projectile_speed = 0.15
mortar_turret_entity.attack_parameters.range = 50
mortar_turret_entity.attack_parameters.min_range = 10
mortar_turret_entity.attack_parameters.cooldown = 600
mortar_turret_entity.attack_parameters.ammo_categories = {"mortar-bomb", constants.mortar_strategy_ammo_category}
mortar_turret_entity.attack_parameters.ammo_category = nil
mortar_turret_entity.circuit_connector = circuit_connector_definitions.create_vector
(
    universal_connector_template,
    {
        { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
        { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
        { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
        { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
    }
)
mortar_turret_entity.circuit_wire_max_distance = default_circuit_wire_max_distance

local mortar_turret_item = data.raw["item"]["mortar-turret"]
mortar_turret_item.stack_size = 10
mortar_turret_item.subgroup = "turret"

-- update ironclad turret parameters
local ironclad_mortar_turret = data.raw["gun"]["ironclad-mortar"]
ironclad_mortar_turret.attack_parameters.ammo_category = nil
ironclad_mortar_turret.attack_parameters.ammo_categories = {"mortar-bomb", constants.mortar_strategy_ammo_category}
