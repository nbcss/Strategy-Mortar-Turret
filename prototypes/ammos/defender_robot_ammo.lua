local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = constants.defender_ammo
local projectile_stream_name = constants.defender_stream

data:extend {
    {
        type = "ammo",
        name = ammo_name,
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
            cooldown_modifier = 1 / 0.75,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = projectile_stream_name,
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
        type = "recipe",
        name = ammo_name,
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "iron-plate", amount = 5},
            {type = "item", name = "electronic-circuit", amount = 3},
            {type = "item", name = "defender-capsule", amount = 1}
        },
        results = {
            {type = "item", name = ammo_name, amount = 1},
        }
    },
    common.create_mortar_stream{
        name = projectile_stream_name,
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
    },
    util.merge{data.raw["combat-robot"]["defender"], {
        name = "deployed-defender-robot",
        speed = 0.008,
        max_speed = 0.008,
        time_to_live = 60 * 30,  --reduced TTL
        hidden = true,
        hidden_in_factoriopedia = true,
        localised_name = {"entity-name.defender"},
        created_effect = common.robot_deploy_effect(),
    }},
}