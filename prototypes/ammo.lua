local constants = require("constants")
local source_offset = { 0, 0.25 }

data:extend{
    {
        type = "ammo",
        name = constants.slowdown_ammo,
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
                    stream = constants.slowdown_stream,
                    source_offset = source_offset
                }
            }
        }
    },
    {
        type = "ammo",
        name = constants.defender_ammo,
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
            range_modifier = 0.8,
            cooldown_modifier = 2,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = constants.defender_stream,
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
        name = constants.distractor_ammo,
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
            range_modifier = 0.8,
            cooldown_modifier = 2,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = constants.distractor_stream,
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
        name = constants.destroyer_ammo,
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
            range_modifier = 0.8,
            cooldown_modifier = 2,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = constants.destroyer_stream,
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
        name = constants.energy_ammo,
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
            cooldown_modifier = 1,
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = constants.energy_stream,
                    source_offset = source_offset
                }
            }
        }
    },
    {
        type = "ammo",
        name = constants.heavy_ammo,
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
                    stream = constants.heavy_stream,
                    source_offset = source_offset
                }
            }
        }
    }
}