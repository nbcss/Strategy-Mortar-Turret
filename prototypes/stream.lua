local constants = require("constants")

local mortar_stream_template = table.deepcopy(data.raw["stream"]["mortar-bomb-projectile-stream"])
mortar_stream_template.action = {}
mortar_stream_template.particle = {}

data:extend {
    -- fire projectile, optionally provide by gunboat + mortar turret fork
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
    -- Poison shell stream
    util.merge { mortar_stream_template, {
        name = constants.poison_stream,
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
    } },
    -- Slowdown shell stream
    util.merge { mortar_stream_template, {
        name = constants.slowdown_stream,
        particle = data.raw["projectile"]["slowdown-capsule"].animation,
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "create-entity",
                        entity_name = "slowdown-capsule-explosion"
                    }
                }
            },
            {
                type = "area",
                radius = 9,
                force = "enemy",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "create-sticker",
                        sticker = "slowdown-sticker",
                        show_in_tooltip = true
                    }
                }
            }
        }
    } },
    -- Fire shell stream
    util.merge { mortar_stream_template, {
        name = constants.fire_stream,
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
    } },
    -- Defender robot bomb stream
    util.merge { mortar_stream_template, {
        name = constants.defender_stream,
        particle = data.raw["projectile"]["defender-capsule"].animation,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = "deployed-defender-robot"
                    },
                    {
                        type = "create-entity",
                        entity_name = "mortar-turret-robot-locator"
                    }
                }
            }
        }
    } },
    -- Distractor robot bomb stream
    util.merge { mortar_stream_template, {
        name = constants.distractor_stream,
        particle = data.raw["projectile"]["distractor-capsule"].animation,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = "deployed-distractor-robot",
                        offsets = { { 1, -1 }, { -1, -1 }, { 0, 1 } }
                    },
                    {
                        type = "create-entity",
                        entity_name = "mortar-turret-robot-locator"
                    }
                }
            }
        }
    } },
    -- Destroyer robot bomb stream
    util.merge { mortar_stream_template, {
        name = constants.destroyer_stream,
        particle = data.raw["projectile"]["destroyer-capsule"].animation,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = "deployed-destroyer-robot",
                        offsets = { { -2, -2 }, { -2, 2 }, { 2, -2 }, { 2, 2 }, { 0, 0 } }
                    },
                    {
                        type = "create-entity",
                        entity_name = "mortar-turret-robot-locator"
                    }
                }
            }
        }
    } },
    -- Energy bomb stream TODO: add particle
    util.merge { mortar_stream_template, {
        name = constants.energy_stream,
        particle = data.raw["artillery-projectile"]["artillery-projectile"].picture,
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-entity",
                            entity_name = "medium-explosion"
                        },
                        {
                            type = "create-entity",
                            entity_name = "mortar-turret-electric-effect"
                        }
                    }
                }
            },
            {
                type = "area",
                radius = 8,
                force = "enemy",
                action_delivery = {
                    {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { type = "electric", amount = 100 },
                            }
                        }
                    }
                }
            }
        }
    } },
    -- Heavy bomb stream
    util.merge { mortar_stream_template, {
        name = constants.heavy_stream,
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
    } },
}
