local util = require("util")

data:extend{{
    type = "item-subgroup",
    name = "mortar-bomb-ammo",
    group = "combat",
    order = "b-a"
}}

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
require("prototypes.robot")