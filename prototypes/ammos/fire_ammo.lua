local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-fire-bomb"
local projectile_stream_name = "mortar-fire-bomb-projectile-stream"

if settings.startup[constants.name_prefix.."enable-ammo-"..ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "dc",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-fire-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        ammo_category = constants.strategy_mortar_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1,
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = projectile_stream_name,
                    source_offset = source_offset
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
            {type = "item", name = "flamethrower-ammo", amount = 1}
        },
        results = {
            {type = "item", name = ammo_name, amount = 1},
        }
    },
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-fire-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "mortar-turret", "flamethrower" },
        order = "xbc",
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
            },
            time = 30
        },
    },
    common.create_mortar_stream{
        name = projectile_stream_name,
        particle = data.raw["projectile"]["cluster-grenade"].animation,
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-entity",
                            entity_name = "explosion"
                        },
                        {
                            type = "create-fire",
                            entity_name = "fire-flame",
                            show_in_tooltip = false,
                            initial_ground_flame_count = 2
                        }
                    }
                }
            },
            {
                type = "area",
                radius = 2.5,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-sticker",
                            sticker = "fire-sticker",
                            show_in_tooltip = true
                        },
                        {
                            type = "damage",
                            damage = { amount = 35, type = "fire" }
                        }
                    }
                }
            },
            {
                type = "cluster",
                cluster_count = 5,
                distance = 5,
                action_delivery = {
                    type = "projectile",
                    projectile = "fire-bomb-splash",
                    direction_deviation = 0.6,
                    starting_speed = 10
                }
            },
            {
                type = "cluster",
                cluster_count = 7,
                distance = 7.5,
                action_delivery = {
                    type = "projectile",
                    projectile = "fire-bomb-splash",
                    direction_deviation = 0.6,
                    starting_speed = 10
                }
            }
        }
    },
    {
        type = "projectile",
        name = "fire-bomb-splash",
        flags = { "not-on-map" },
        acceleration = 10,
        action = {
            {
                type = "direct",
                action_delivery =
                {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-fire",
                            entity_name = "fire-flame",
                            show_in_tooltip = false,
                            initial_ground_flame_count = 2
                        }
                    }
                }
            },
            {
                type = "area",
                radius = 2.5,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-sticker",
                            sticker = "fire-sticker",
                            show_in_tooltip = true
                        },
                        {
                            type = "damage",
                            damage = { amount = 20, type = "fire" }
                        }
                    }
                }
            }
        }
    },
}