local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-heavy-ammo"
local projectile_stream_name = "mortar-heavy-projectile-stream"
local cooldown_penalty = 5

if settings.startup[constants.name_prefix.."enable-ammo-"..ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "bb",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-heavy-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        custom_tooltip_fields = {
            {
                name = { "strategy-mortar-turret.turret-cooldown-penalty" },
                value = { "seconds", tostring(cooldown_penalty) },
            }
        },
        ammo_category = constants.physical_mortar_ammo_category,
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
                            effect_id = "mortar-turret-cooldown-" .. cooldown_penalty
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
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-heavy-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "mortar-turret", "military-4" },
        order = "xcb",
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "utility-science-pack",    1 },
            },
            time = 30
        },
    },
    common.create_mortar_stream{
        name = projectile_stream_name,
        particle = data.raw["artillery-projectile"]["artillery-projectile"].picture,
        target_position_deviation = 0.5,
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