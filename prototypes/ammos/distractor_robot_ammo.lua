local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-distractor-robot-ammo"
local projectile_stream_name = "mortar-distractor-robot-projectile-stream"

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "j",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-distractor-ammo.png",
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
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "advanced-circuit", amount = 2},
            {type = "item", name = "distractor-capsule", amount = 1}
        },
        results = {
            {type = "item", name = ammo_name, amount = 1},
        }
    },
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-distractor-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "mortar-turret", "distractor" },
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
            },
            time = 30
        },
        order = "e-c-c"
    },
    common.create_mortar_stream{
        name = projectile_stream_name,
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
                        offsets = { { 3, -3 }, { -3, -3 }, { 0, 3 } }
                    },
                    {
                        type = "create-entity",
                        entity_name = "mortar-turret-robot-locator"
                    }
                }
            }
        }
    },
    util.merge{data.raw["combat-robot"]["distractor"], {
        name = "deployed-distractor-robot",
        speed = 0,
        max_speed = 0,
        time_to_live = 60 * 45,  --reduced TTL
        hidden = true,
        hidden_in_factoriopedia = true,
        localised_name = {"entity-name.distractor"},
        created_effect = common.robot_deploy_effect(),
    }},
}