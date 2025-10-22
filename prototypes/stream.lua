local constants = require("constants")

local mortar_stream_template = table.deepcopy(data.raw["stream"]["mortar-bomb-projectile-stream"])
mortar_stream_template.action = {}

data:extend{
    -- Slowdown shell stream
    util.merge{mortar_stream_template, {
        name = constants.slowdown_stream,
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
    util.merge{mortar_stream_template, {
        name = constants.defender_stream,
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
    util.merge{mortar_stream_template, {
        name = constants.distractor_stream,
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
    util.merge{mortar_stream_template, {
        name = constants.destroyer_stream,
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
    -- Energy bomb stream
    util.merge{mortar_stream_template, {
        name = constants.energy_stream,
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
    }},
    -- Heavy bomb stream
    util.merge{mortar_stream_template, {
        name = constants.heavy_stream,
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
                            offset_deviation = {{-4, -4}, {4, 4}},
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
    }},
}