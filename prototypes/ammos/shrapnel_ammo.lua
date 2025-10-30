local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-shrapnel-ammo"
local projectile_stream_name = "mortar-shrapnel-projectile-stream"

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "z",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-slowdown-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1.0,
            cooldown_modifier = 0.5,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = projectile_stream_name,
                        source_offset = source_offset
                    }
                }
            }
        }
    },
    {
        type = "recipe",
        name = ammo_name,
        enabled = false,
        energy_required = 8,
        ingredients = {
            { type = "item", name = "steel-plate",   amount = 2 },
            { type = "item", name = "grenade",       amount = 1 },
            { type = "item", name = "shotgun-shell", amount = 1 }
        },
        results = {
            { type = "item", name = ammo_name, amount = 1 },
        }
    },
    util.merge { data.raw["explosion"]["explosion"], {
        name = "test-explosion",
        explosion_effect = {
            type = "direct",
            action_delivery = {
                {
                    type = "instant",
                    source_effects = {
                        {
                            type = "nested-result",
                            action = {
                                type = "direct",
                                repeat_count = 50,
                                action_delivery = {
                                    type = "projectile",
                                    projectile = "shotgun-pellet",
                                    starting_speed = 1,
                                    starting_speed_deviation = 0.1,
                                    direction_deviation = 2.0,
                                    range_deviation = 0.3,
                                    max_range = 15,
                                }
                            }
                        },
                    }
                },
            }
        }
    } },
    common.create_mortar_stream {
        name = projectile_stream_name,
        particle = data.raw["projectile"]["slowdown-capsule"].animation,
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-entity",
                            entity_name = "test-explosion"
                        },

                    }
                }
            }
        }
    },
}
