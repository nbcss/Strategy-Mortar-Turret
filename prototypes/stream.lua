local bomb_stream_template = table.deepcopy(data.raw["stream"]["mortar-bomb-projectile-stream"])
bomb_stream_template.action = {}

data:extend{
    -- Energy bomb stream
    util.merge{bomb_stream_template, {
        name = "mortar-energy-bomb-projectile-stream",
        action = {
            {
                type = "direct",
                action_delivery = {
                    {
                        type = "instant",
                        target_effects = {
                            {
                                type = "create-entity",
                                entity_name = "mortar-energy-explosion"
                            }
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
                                damage = { type = "electric", amount = 250 },
                            },
                            {
                                type = "create-sticker",
                                sticker = "electric-mini-stun"
                            },
                            {
                                type = "push-back",
                                distance = 2
                            }
                        }
                    }
                }
            }
        },
    }},
    -- Heavy bomb stream
    util.merge{bomb_stream_template, {
        name = "mortar-heavy-bomb-projectile-stream",
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "create-entity",
                        entity_name = "explosion"
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
    }},
    -- Slowdown shell stream
    util.merge{bomb_stream_template, {
        name = "mortar-slowdown-projectile-stream",
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
    }},
    -- Defender robot bomb stream
    util.merge{bomb_stream_template, {
        name = "mortar-defender-robot-bomb-projectile-stream",
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
    }},
    -- Distractor robot bomb stream
    util.merge{bomb_stream_template, {
        name = "mortar-distractor-robot-bomb-projectile-stream",
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = "deployed-distractor-robot",
                        offsets = {{1, -1},{-1, -1},{0, 1}}
                    },
                    {
                        type = "create-entity",
                        entity_name = "mortar-turret-robot-locator"
                    }
                }
            }
        }
    }},
    -- Destroyer robot bomb stream
    util.merge{bomb_stream_template, {
        name = "mortar-destroyer-robot-bomb-projectile-stream",
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = "deployed-destroyer-robot",
                        offsets = {{-2, -2},{-2, 2},{2, -2},{2, 2},{0, 0}}
                    },
                    {
                        type = "create-entity",
                        entity_name = "mortar-turret-robot-locator"
                    }
                }
            }
        }
    }},
}