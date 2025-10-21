local source_offset = { 0, 0.25 }

data:extend{
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
    },
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
    },
    {
        type = "ammo",
        name = "mortar-distractor-robot-bomb",
        order = "e",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-distractor-bomb.png",
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
                    stream = "mortar-distractor-robot-bomb-projectile-stream",
                    source_offset = source_offset
                }
            }
        }
    },
    {
        type = "ammo",
        name = "mortar-destroyer-robot-bomb",
        order = "e",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-destroyer-bomb.png",
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
                    stream = "mortar-destroyer-robot-bomb-projectile-stream",
                    source_offset = source_offset
                }
            }
        }
    }
}