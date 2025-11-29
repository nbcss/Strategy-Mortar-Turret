local constants = require("constants")
local common = require("prototypes.common")
local sounds = require("__base__.prototypes.entity.sounds")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-poison-bomb"
local projectile_stream_name = "mortar-poison-bomb-projectile-stream"
local poison_duration = 20

if settings.startup[constants.name_prefix .. "enable-ammo-" .. ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "da",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-poison-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        custom_tooltip_fields = {
            {
                name = { "description.duration" },
                value = { "seconds", tostring(poison_duration) },
            }
        },
        ammo_category = constants.strategy_mortar_ammo_category,
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
                        source_offset = source_offset,
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
            { type = "item", name = "steel-plate",    amount = 2 },
            { type = "item", name = "grenade",        amount = 1 },
            { type = "item", name = "poison-capsule", amount = 1 }
        },
        results = {
            { type = "item", name = ammo_name, amount = 1 },
        }
    },
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-poison-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "mortar-turret", "military-3" },
        order = "xba",
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
            },
            time = 30
        },
    },
    common.create_mortar_stream {
        name = projectile_stream_name,
        particle = data.raw["projectile"]["poison-capsule"].animation,
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-smoke",
                            show_in_tooltip = true,
                            entity_name = "mortar-poison-cloud",
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
    {
        name = "mortar-poison-cloud",
        type = "smoke-with-trigger",
        flags = { "not-on-map" },
        localised_name = {"entity-name.poison-cloud"},
        hidden = true,
        show_when_smoke_off = true,
        particle_count = 16,
        particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
        particle_distance_scale_factor = 0.5,
        particle_scale_factor = { 1, 0.707 },
        wave_speed = { 1 / 80, 1 / 60 },
        wave_distance = { 0.3, 0.2 },
        spread_duration_variation = 20,
        particle_duration_variation = 60 * 3,
        render_layer = "object",

        affected_by_wind = false,
        cyclic = true,
        duration = 60 * poison_duration,
        fade_away_duration = 2 * 60,
        spread_duration = 20,
        color = { 0.239, 0.875, 0.992, 0.690 }, -- #3ddffdb0,

        animation = {
            width = 152,
            height = 120,
            line_length = 5,
            frame_count = 60,
            shift = { -0.53125, -0.4375 },
            priority = "high",
            animation_speed = 0.25,
            filename = "__base__/graphics/entity/smoke/smoke.png",
            flags = { "smoke" }
        },

        created_effect = {
            {
                type = "cluster",
                cluster_count = 10,
                distance = 4.7,
                distance_deviation = 5,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-smoke",
                            show_in_tooltip = false,
                            entity_name = "poison-cloud-visual-dummy",
                            initial_height = 0
                        },
                        {
                            type = "play-sound",
                            sound = sounds.poison_capsule_explosion
                        }
                    }
                }
            },
            {
                type = "cluster",
                cluster_count = 11,
                distance = 9.5 * 1.1,
                distance_deviation = 2,
                action_delivery =
                {
                    type = "instant",
                    target_effects =
                    {
                        {
                            type = "create-smoke",
                            show_in_tooltip = false,
                            entity_name = "poison-cloud-visual-dummy",
                            initial_height = 0
                        }
                    }
                }
            }
        },
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "nested-result",
                    action = {
                        type = "area",
                        radius = 13,
                        entity_flags = { "breaths-air" },
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                type = "damage",
                                damage = { amount = 10, type = "poison" }
                            }
                        }
                    }
                }
            }
        },
        action_cooldown = 30
    },
}
