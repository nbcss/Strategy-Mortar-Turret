local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-illumination-ammo"
local projectile_stream_name = "mortar-illumination-projectile-stream"

if settings.startup[constants.name_prefix.."enable-ammo-"..ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "f",
        icons = {
            {
                icon = "__strategy-mortar-turret__/graphics/icons/mortar-illumination-ammo-base.png",
                icon_size = 64,
            },
            {
                icon = "__strategy-mortar-turret__/graphics/icons/mortar-illumination-ammo-glow.png",
                icon_size = 64,
            },
        },
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        custom_tooltip_fields = {
            {
                name = { "strategy-mortar-turret.base-illumination-damage-bonus" },
                value = { "format-percent", "+" .. tostring(10) },
            },
            {
                name = { "strategy-mortar-turret.night-illumination-damage-bonus" },
                value = { "format-percent", "+" .. tostring(30) },
            },
            {
                name = { "description.duration" },
                value = { "seconds", tostring(30) },
            }
        },
        ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1,
            cooldown_modifier = 1 / 0.75,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = projectile_stream_name,
                        source_offset = source_offset,
                        source_effects = {
                            type = "play-sound",
                            play_on_target_position = true,
                            sound = {
                                aggregation = {
                                    max_count = 1,
                                    remove = false
                                },
                                variations = {
                                    {
                                        filename = "__strategy-mortar-turret__/sounds/flare-launch1.ogg",
                                        volume = 0.5
                                    },
                                    {
                                        filename = "__strategy-mortar-turret__/sounds/flare-launch2.ogg",
                                        volume = 0.5
                                    }
                                }
                            }
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
            {type = "item", name = "iron-plate", amount = 2},
            {type = "item", name = "sulfur", amount = 3},
            {type = "item", name = "coal", amount = 1}
        },
        results = {
            {type = "item", name = ammo_name, amount = 1},
        }
    },
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-illumination-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "mortar-turret", "sulfur-processing" },
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
            },
            time = 30
        },
        order = "e-c-c"
    },
    common.create_mortar_stream{
        name = projectile_stream_name,
        particle = {
            filename = "__strategy-mortar-turret__/graphics/animations/flare.png",
            priority = "extra-high",
            width = 128,
            height = 128,
            frame_count = 1,
        },
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = "mortar-turret-illumination-effect",
                    }
                }
            }
        }
    },
    {
        type = "damage-type",
        name = "illumination",
    },
    {
        type = "trivial-smoke",
        name = "illuminating-smoke",
        animation = {
            filename = "__base__/graphics/entity/smoke-fast/smoke-fast.png",
            priority = "high",
            width = 50,
            height = 50,
            frame_count = 16,
            animation_speed = 16 / 60,
            scale = 0.5
        },
        duration = 60,
        fade_away_duration = 30,
        show_when_smoke_off = true
    },
    {
        type = "explosion",
        name = "illuminating-flare",
        flags = { "not-on-map" },
        animations = {
            filename = "__strategy-mortar-turret__/graphics/animations/lightning-animation.png",
            priority = "high",
            width = 64,
            height = 64,
            frame_count = 16,
            animation_speed = 16 / 20,
        },
        light = { intensity = 1.0, size = 50, color = { r = 1.000, g = 0.888, b = 0.419 } },
        light_intensity_factor_final = 1.0,
        light_intensity_factor_initial = 1.0,
        light_size_factor_initial = 1.0,
        light_size_factor_final = 1.0,
    },
    {
        name = "mortar-turret-illumination-effect",
        type = "smoke-with-trigger",
        flags = { "not-on-map" },
        affected_by_wind = false,
        hidden = true,
        cyclic = true,
        duration = 60 * 30,
        fade_away_duration = 60 * 1,
        spread_duration = 10,
        animation = {
            filename = "__strategy-mortar-turret__/graphics/animations/flare.png",
            priority = "high",
            width = 128,
            height = 128,
            frame_count = 1,
            scale = 0.5,
        },
        working_sound = {
            sound = { filename = "__strategy-mortar-turret__/sounds/flare-burning.ogg" },
            apparent_volume = 0.5,
            audible_distance_modifier = 0.5,
            max_sounds_per_type = 3,
        },
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-explosion",
                        entity_name = "illuminating-flare"
                    },
                    {
                        type = "create-trivial-smoke",
                        smoke_name = "illuminating-smoke",
                        starting_frame = 4,
                        starting_frame_deviation = 4,
                        offsets = {{0, -1}}
                    },
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            radius = 14,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    type = "script",
                                    show_in_tooltip = true,
                                    effect_id = "mortar-turret-illumination-damage"
                                }
                            }
                        }
                    }
                }
            }
        },
        action_cooldown = 20
    },
}