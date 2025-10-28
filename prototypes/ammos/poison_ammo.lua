local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = constants.poison_ammo
local projectile_stream_name = constants.poison_stream

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "c",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-poison-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        custom_tooltip_fields = {
            {
                name = { "description.duration" },
                value = { "seconds", tostring(20) },
            }
        },
        ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1.0,
            cooldown_modifier = 2.0,
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
            {type = "item", name = "steel-plate", amount = 2},
            {type = "item", name = "grenade", amount = 1},
            {type = "item", name = "poison-capsule", amount = 1}
        },
        results = {
            {type = "item", name = ammo_name, amount = 1},
        }
    },
    common.create_mortar_stream{
        name = projectile_stream_name,
        particle = data.raw["projectile"]["poison-capsule"].animation,
        action = {
            {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-smoke",
                            show_in_tooltip = true,
                            entity_name = "poison-cloud",
                            initial_height = 0
                        },
                        {
                            type = "create-particle",
                            particle_name = "poison-capsule-metal-particle",
                            repeat_count = 8,
                            initial_height = 1,
                            initial_vertical_speed = 0.1,
                            initial_vertical_speed_deviation = 0.05,
                            offset_deviation = { { -0.1, -0.1 }, { 0.1, 0.1 } },
                            speed_from_center = 0.05,
                            speed_from_center_deviation = 0.01
                        }
                    }
                }
            }
        }
    },
}