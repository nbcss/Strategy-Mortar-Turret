local constants = require("constants")
local common = require("prototypes.common")
local fireutil = require("__base__.prototypes.fire-util")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-fire-bomb"
local projectile_stream_name = "mortar-fire-bomb-projectile-stream"

if settings.startup[constants.name_prefix .. "enable-ammo-" .. ammo_name].value == false then
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
            cooldown_modifier = 1 / 0.75,
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
            { type = "item", name = "steel-plate",       amount = 2 },
            { type = "item", name = "grenade",           amount = 1 },
            { type = "item", name = "flamethrower-ammo", amount = 1 }
        },
        results = {
            { type = "item", name = ammo_name, amount = 1 },
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
    common.create_mortar_stream {
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
                            entity_name = "mortar-fire-flame",
                            show_in_tooltip = false,
                            initial_ground_flame_count = 20
                        }
                    }
                }
            },
            {
                type = "area",
                radius = 3,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-sticker",
                            sticker = "fire-sticker",
                            show_in_tooltip = true,
                        }
                    }
                }
            },
            {
                type = "cluster",
                cluster_count = 20,
                distance = 4,
                distance_deviation = 2,
                action_delivery = {
                    type = "stream",
                    stream = "mortar-fire-stream",
                }
            },
        }
    },
    {
        type = "stream",
        name = "mortar-fire-stream",
        flags = { "not-on-map" },
        hidden = true,
        smoke_sources = {
            {
                name = "soft-fire-smoke",
                frequency = 0.05,      --0.25,
                position = { 0.0, 0 }, -- -0.8},
                starting_frame_deviation = 60
            }
        },
        particle_buffer_size = 90,
        particle_spawn_interval = 2,
        particle_spawn_timeout = 8,
        particle_vertical_acceleration = 0.005 * 0.60,
        particle_horizontal_speed = 0.2 * 0.75 * 1.5,
        particle_horizontal_speed_deviation = 0.005 * 0.70,
        particle_start_alpha = 0.5 / 0.666,
        particle_end_alpha = 1,
        particle_start_scale = 0.2,
        particle_loop_frame_count = 3,
        particle_fade_out_threshold = 0.9,
        particle_loop_exit_threshold = 0.25,
        action = {
            {
                type = "area",
                radius = 2,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        -- {
                        --     type = "create-sticker",
                        --     sticker = "fire-sticker",
                        --     show_in_tooltip = true
                        -- },
                        {
                            type = "damage",
                            damage = { amount = 20 / 60, type = "fire" },
                            apply_damage_to_trees = false,
                        }
                    }
                }
            },
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-fire",
                            entity_name = "mortar-fire-flame",
                            show_in_tooltip = true,
                        }
                    }
                }
            }
        },
        spine_animation = util.draw_as_glow {
            filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-fire-stream-spine.png",
            blend_mode = "normal",
            tint = { r = 1, g = 1, b = 1, a = 0.2 },
            line_length = 6,
            width = 54,
            height = 26,
            frame_count = 36,
            animation_speed = 2,
            shift = { 0, 0 }
        },
        shadow = {
            filename = "__base__/graphics/entity/acid-projectile/projectile-shadow.png",
            line_length = 5,
            width = 28,
            height = 16,
            frame_count = 33,
            priority = "high",
            shift = { -0.09, 0.395 }
        },
        particle = util.draw_as_glow {
            filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
            priority = "extra-high",
            blend_mode = "normal",
            tint = { r = 0.9, g = 0.9, b = 0.9, a = 0.55 },
            line_length = 6,
            width = 124,
            height = 108,
            frame_count = 36,
            scale = 0.666,
        },
    },
    fireutil.add_basic_fire_graphics_and_effects_definitions {
        type = "fire",
        name = "mortar-fire-flame",
        localised_name = { "entity-name.fire-flame" },
        flags = { "placeable-off-grid", "not-on-map" },
        hidden = true,
        damage_per_tick = { amount = 15 / 60, type = "fire" },
        maximum_damage_multiplier = 6,
        damage_multiplier_increase_per_added_fuel = 1,
        damage_multiplier_decrease_per_tick = 0.005,

        spawn_entity = "fire-flame-on-tree",

        spread_delay = 300,
        spread_delay_deviation = 180,
        maximum_spread_count = 100,

        emissions_per_second = { pollution = 0.005 },

        initial_lifetime = 60 * 10,
        lifetime_increase_by = 150,
        lifetime_increase_cooldown = 4,
        maximum_lifetime = 60 * 20,
        delay_between_initial_flames = 10,
    }
}
