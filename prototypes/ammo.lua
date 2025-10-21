local source_offset = { 0, 0.25 }
local mortar_energy_stream = util.table.deepcopy(data.raw["stream"]["mortar-bomb-projectile-stream"]);
mortar_energy_stream.name = "mortar-energy-bomb-projectile-stream"
mortar_energy_stream.action = {
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
}
data:extend({mortar_energy_stream});

data:extend({
    {
        type = "ammo",
        name = "mortar-energy-bomb",
        order = "e",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-energy-bomb.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = "mortar-bomb-ammo",
        stack_size = 200,
		ammo_category = "mortar-bomb",
        ammo_type = {
            category = "mortar-bomb",
            target_type = "position",
            clamp_position = true,
            range_modifier = 1,
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = "mortar-energy-bomb-projectile-stream",
                    source_offset = source_offset
                }
            }
        }
    }
})

local mortar_defender_robot_stream = util.table.deepcopy(data.raw["stream"]["mortar-bomb-projectile-stream"]);
mortar_defender_robot_stream.name = "mortar-defender-robot-bomb-projectile-stream"
mortar_defender_robot_stream.action = {
    {
        type = "direct",
        action_delivery = {
            {
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
    }
}

data:extend({mortar_defender_robot_stream, 
    {
        type = "ammo",
        name = "mortar-defender-robot-bomb",
        order = "e",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-defender-bomb.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = "mortar-bomb-ammo",
        stack_size = 200,
		ammo_category = "mortar-bomb",
        ammo_type = {
            category = "mortar-bomb",
            target_type = "position",
            clamp_position = true,
            range_modifier = 1,
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = "mortar-defender-robot-bomb-projectile-stream",
                    source_offset = source_offset
                }
            }
        }
    }
})