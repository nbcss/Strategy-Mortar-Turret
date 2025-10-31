local constants = require("constants")

-- mortar turret
require("prototypes.mortar_turret")
-- ammos
require("prototypes.ammos.poison_ammo")
require("prototypes.ammos.slowdown_ammo")
require("prototypes.ammos.fire_ammo")
require("prototypes.ammos.defender_robot_ammo")
require("prototypes.ammos.distractor_robot_ammo")
require("prototypes.ammos.destroyer_robot_ammo")
require("prototypes.ammos.energy_ammo")
require("prototypes.ammos.heavy_ammo")
require("prototypes.ammos.illumination_ammo")
require("prototypes.ammos.hypnosis_ammo")
-- require("prototypes.ammos.shrapnel_ammo")
-- other
require("prototypes.misc")

-- change to 360 angle turret
if settings.startup[constants.name_prefix.."directional-turret-range"].value == false then
    local turret = data.raw["ammo-turret"]["mortar-turret"]
    turret.attack_parameters.turn_range = nil
end

-- update ironclad turret to use strategy ammo
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

local mortar_fire_bomb_ammo_item = data.raw["ammo"]["mortar-fire-bomb"]
mortar_fire_bomb_ammo_item.icon = "__strategy-mortar-turret__/graphics/icons/mortar-fire-ammo.png"
mortar_fire_bomb_ammo_item.subgroup = constants.mortar_ammo_subgroup
mortar_fire_bomb_ammo_item.ammo_category = constants.mortar_strategy_ammo_category
mortar_fire_bomb_ammo_item.order = "e"
data.raw["recipe"]["mortar-fire-bomb"].icon = "__strategy-mortar-turret__/graphics/icons/mortar-fire-ammo.png"
