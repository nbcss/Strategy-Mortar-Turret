local robot_deploy_effect = {
    {
        type = "direct",
        action_delivery = {
            type = "instant",
            target_effects = {
                type = "script",
                effect_id = "mortar-turret-robot-deploy"
            }
        }
    }
}

data:extend{
    {
        type = "combat-robot",
        name = "mortar-turret-robot-locator",
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
        time_to_live = 60 * 60,
        max_health = 10000000,
        alert_when_damaged = false,
        is_military_target = false,
        created_effect = robot_deploy_effect,
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
                        source_offset = {0, -0.5},
                        add_to_shooter = false
                    }
                }
            }
        },
    },
    util.merge{data.raw["combat-robot"]["defender"], {
        name = "deployed-defender-robot",
        speed = 0.008,
        max_speed = 0.008,
        time_to_live = 60 * 30,  --reduced TTL
        hidden = true,
        hidden_in_factoriopedia = true,
        localised_name = {"entity-name.defender"},
        created_effect = robot_deploy_effect,
    }},
    util.merge{data.raw["combat-robot"]["distractor"], {
        name = "deployed-distractor-robot",
        speed = 0,
        max_speed = 0,
        time_to_live = 60 * 45,  --reduced TTL
        hidden = true,
        hidden_in_factoriopedia = true,
        localised_name = {"entity-name.distractor"},
        created_effect = robot_deploy_effect,
    }},
    util.merge{data.raw["combat-robot"]["destroyer"], {
        name = "deployed-destroyer-robot",
        speed = 0.008,
        max_speed = 0.008,
        time_to_live = 60 * 60,  --reduced TTL
        hidden = true,
        hidden_in_factoriopedia = true,
        localised_name = {"entity-name.destroyer"},
        created_effect = robot_deploy_effect,
    }}
}
