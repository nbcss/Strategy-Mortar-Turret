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
        type = "combat-robot",
        name = "mortar-turret-illumination-effect",
        attack_parameters = {
            type = "projectile",
            cooldown = 10000000,
            range = 0,
            damage_modifier = 0.1,
            ammo_type = {},
            ammo_category = "bullet"
        },
        follows_player = false,
        flags = { "not-on-map", "not-blueprintable", "not-selectable-in-game", "not-deconstructable" },
        hidden = true,
        speed = 0,
        max_speed = 0,
        time_to_live = 60 * 10,
        max_health = 10000000,
        alert_when_damaged = false,
        is_military_target = false,
        light = {
            type = "basic",
            intensity = 0.9,
            size = 50,
            color = { r = 1, g = 0.7, b = 0.4, a = 0.2 },
        },
        -- created_effect = {},
    },
    {
        name = "mortar-turret-illumination-trigger",
        type = "smoke-with-trigger",
        flags = { "not-on-map" },
        hidden = true,
        cyclic = true,
        duration = 60 * 10,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "nested-result",
                    action = {
                        type = "area",
                        radius = 11,
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
        },
        action_cooldown = 10
    },
}
