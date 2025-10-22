local constants = require("constants")

require("prototypes.ammo")
require("prototypes.stream")
require("prototypes.robot")
require("prototypes.recipe")
require("postprocessing.turret_update")

local beam_effect = util.table.deepcopy(data.raw["beam"]["electric-beam"])
beam_effect.name = "electric-beam-no-damage"
beam_effect.action = nil

data:extend{ beam_effect,
    {
        type = "ammo-category",
        name = constants.mortar_strategy_ammo_category,
        icon = "__aai-vehicles-ironclad__/graphics/icons/mortar-bomb-ammo-category.png",
        subgroup = "ammo-category",
        bonus_gui_order = "z",
    },
    {
        type = "item-subgroup",
        name = constants.mortar_ammo_subgroup,
        group = "combat",
        order = "b-a"
    }
}

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
mortar_fire_bomb_ammo_item.icon = "__strategy-mortar-turret__/graphics/icons/mortar-fire-ammo.png"
mortar_fire_bomb_ammo_item.subgroup = constants.mortar_ammo_subgroup
mortar_fire_bomb_ammo_item.ammo_category = constants.mortar_strategy_ammo_category
mortar_fire_bomb_ammo_item.order = "e"
