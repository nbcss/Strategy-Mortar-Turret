local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = constants.heavy_ammo
local projectile_stream_name = constants.heavy_stream

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "j",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-heavy-ammo.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        custom_tooltip_fields = {
            {
                name = { "strategy-mortar-turret.turret-cooldown-penalty" },
                value = { "seconds", tostring(10) },
            }
        },
        ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1.6,
            cooldown_modifier = 2.0,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = projectile_stream_name,
                        source_offset = source_offset
                    },
                    {
                        type = "instant",
                        source_effects = {
                            type = "script",
                            effect_id = "mortar-turret-cooldown-20"
                        }
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
            {type = "item", name = "steel-plate", amount = 8},
            {type = "item", name = "explosives", amount = 5},
            {type = "item", name = "advanced-circuit", amount = 2}
        },
        results = {
            {type = "item", name = ammo_name, amount = 1},
        }
    },
    common.create_mortar_stream{
        name = projectile_stream_name,
        particle = data.raw["artillery-projectile"]["artillery-projectile"].picture,
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-trivial-smoke",
                            smoke_name = "artillery-smoke",
                            initial_height = 0,
                            speed_from_center = 0.05,
                            speed_from_center_deviation = 0.005,
                            offset_deviation = { { -4, -4 }, { 4, 4 } },
                            max_radius = 3.5,
                            repeat_count = 4 * 4 * 15
                        },
                        {
                            type = "create-entity",
                            entity_name = "big-artillery-explosion"
                        }
                    }
                }
            },
            {
                type = "area",
                radius = 1.5,
                force = "enemy",
                action_delivery = {
                    {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { type = "physical", amount = 250 },
                            }
                        }
                    }
                }
            },
            {
                type = "area",
                radius = 4,
                force = "enemy",
                action_delivery = {
                    {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { type = "explosion", amount = 50 },
                            }
                        }
                    }
                }
            }
        }
    },
}