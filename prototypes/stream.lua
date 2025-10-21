data:extend{
    -- Energy bomb stream
    util.merge{data.raw["stream"]["mortar-bomb-projectile-stream"], {
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
    -- Defender robot bomb stream
    util.merge{data.raw["stream"]["mortar-bomb-projectile-stream"], {
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
    util.merge{data.raw["stream"]["mortar-bomb-projectile-stream"], {
        name = "mortar-distractor-robot-bomb-projectile-stream",
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = "deployed-distractor-robot"
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
    util.merge{data.raw["stream"]["mortar-bomb-projectile-stream"], {
        name = "mortar-destroyer-robot-bomb-projectile-stream",
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        show_in_tooltip = true,
                        entity_name = "deployed-destroyer-robot"
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