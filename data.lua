local constants = require("constants")

data:extend{
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

local energy_explosion = util.table.deepcopy(data.raw["explosion"]["explosion"])
energy_explosion.name = "mortar-energy-explosion"
energy_explosion.explosion_effect = {
    type = "area",
    radius = 8,
    force = "enemy",
    action_delivery = {
        {
            type = "beam",
            beam = "electric-beam-no-sound",
            destroy_with_source_or_target = false,
            max_length = 16,
            duration = 15,
            source_offset = {0, -0.5}
        }
    }
}
data:extend{energy_explosion}

require("prototypes.ammo")
require("prototypes.stream")
require("prototypes.robot")
require("prototypes.recipe")
