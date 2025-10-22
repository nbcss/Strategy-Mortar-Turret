local constants = require("constants")

-- update turret parameters
local mortar_turret_entity = data.raw["ammo-turret"]["mortar-turret"]
mortar_turret_entity.attack_parameters.lead_target_for_projectile_speed = 0.25
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

-- rearrange item group
local mortar_bomb_ammo_item = data.raw["ammo"]["mortar-bomb"]
mortar_bomb_ammo_item.subgroup = constants.mortar_ammo_subgroup
mortar_bomb_ammo_item.order = "a"

local mortar_cluster_bomb_ammo_item = data.raw["ammo"]["mortar-cluster-bomb"]
mortar_cluster_bomb_ammo_item.subgroup = constants.mortar_ammo_subgroup
mortar_cluster_bomb_ammo_item.order = "b"

local mortar_poison_bomb_ammo_item = data.raw["ammo"]["mortar-poison-bomb"]
mortar_poison_bomb_ammo_item.subgroup = constants.mortar_ammo_subgroup
mortar_poison_bomb_ammo_item.ammo_category = constants.mortar_strategy_ammo_category
mortar_poison_bomb_ammo_item.order = "c"

local mortar_fire_bomb_ammo_item = data.raw["ammo"]["mortar-fire-bomb"]
mortar_fire_bomb_ammo_item.subgroup = constants.mortar_ammo_subgroup
mortar_poison_bomb_ammo_item.ammo_category = constants.mortar_strategy_ammo_category
mortar_fire_bomb_ammo_item.order = "d"
