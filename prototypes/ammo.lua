local source_offset = { 0, 0.25 }
local constants = require("constants")

data:extend{
    {
        type = "ammo",
        name = "mortar-energy-bomb",
        order = "h",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-energy-bomb.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
		ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            category = constants.mortar_strategy_ammo_category,
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
        name = "mortar-heavy-bomb",
        order = "i",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-heavy-bomb.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
		ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            category = constants.mortar_strategy_ammo_category,
            target_type = "position",
            clamp_position = true,
            range_modifier = 1.6,
            cooldown_modifier = 2.0,
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = "mortar-heavy-bomb-projectile-stream",
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
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
		ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1,
            cooldown_modifier = 1,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = "mortar-defender-robot-bomb-projectile-stream",
                        source_offset = source_offset
                    },
                    {
                        type = "instant",
                        source_effects = {
                            type = "script",
                            effect_id = "mortar-turret-robot-shoot"
                        }
                    }
                }
            }
        }
    },
    {
        type = "ammo",
        name = "mortar-distractor-robot-bomb",
        order = "f",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-distractor-bomb.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
		ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1,
            cooldown_modifier = 1,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = "mortar-distractor-robot-bomb-projectile-stream",
                        source_offset = source_offset
                    },
                    {
                        type = "instant",
                        source_effects = {
                            type = "script",
                            effect_id = "mortar-turret-robot-shoot"
                        }
                    }
                }
            }
        }
    },
    {
        type = "ammo",
        name = "mortar-destroyer-robot-bomb",
        order = "g",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-destroyer-bomb.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
		ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1,
            cooldown_modifier = 1,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = "mortar-destroyer-robot-bomb-projectile-stream",
                        source_offset = source_offset
                    },
                    {
                        type = "instant",
                        source_effects = {
                            type = "script",
                            effect_id = "mortar-turret-robot-shoot"
                        }
                    }
                }
            }
        }
    }
}