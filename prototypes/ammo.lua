local source_offset = { 0, 0.25 }
local constants = require("constants")

data:extend{
    {
        type = "ammo",
        name = "mortar-slowdown-ammo",
        order = "d",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-slowdown-ammo.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
		ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1,
            cooldown_modifier = 4,
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = "mortar-slowdown-projectile-stream",
                    source_offset = source_offset
                }
            }
        }
    },
    {
        type = "ammo",
        name = "mortar-defender-robot-ammo",
        order = "f",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-defender-ammo.png",
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
        name = "mortar-distractor-robot-ammo",
        order = "g",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-distractor-ammo.png",
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
        name = "mortar-destroyer-robot-ammo",
        order = "h",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-destroyer-ammo.png",
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
    },
        {
        type = "ammo",
        name = "mortar-energy-ammo",
        order = "i",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-energy-ammo.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
		ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
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
        name = "mortar-heavy-ammo",
        order = "j",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-heavy-ammo.png",
        icon_mipmaps = 1,
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
		ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
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
    }
}