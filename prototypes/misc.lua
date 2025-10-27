local constants = require("constants")

local beam_effect = util.table.deepcopy(data.raw["beam"]["electric-beam"])
beam_effect.name = "electric-beam-no-damage"
beam_effect.action = nil

data.extend {
    beam_effect,
    {
        type = "damage-type",
        name = "illumination",
    },
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
    },
    {
        type = "combat-robot",
        name = "mortar-turret-electric-effect",
        attack_parameters = {
            type = "projectile",
            cooldown = 10000000,
            range = 0,
            damage_modifier = 0,
            ammo_type = {},
            ammo_category = "bullet"
        },
        follows_player = false,
        flags = { "not-on-map", "not-blueprintable", "not-selectable-in-game", "not-deconstructable" },
        hidden = true,
        speed = 0,
        max_speed = 0,
        time_to_live = 60 * 2,
        max_health = 10000000,
        alert_when_damaged = false,
        is_military_target = false,
        created_effect = {
            {
                type = "area",
                radius = 6,
                force = "enemy",
                action_delivery =
                {
                    {
                        type = "instant",
                        target_effects =
                        {
                            {
                                type = "create-sticker",
                                sticker = "stun-sticker"
                            },
                            {
                                type = "push-back",
                                distance = 2
                            }
                        }
                    },
                    {
                        type = "beam",
                        beam = "electric-beam-no-damage",
                        max_length = 8,
                        duration = 60,
                        source_offset = { 0, -0.5 },
                        add_to_shooter = false
                    }
                }
            }
        },
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
            animation_speed = 16 / 10,
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
        action_cooldown = 10
    },
}
