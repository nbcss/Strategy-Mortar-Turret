local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-slowdown-ammo"
local projectile_stream_name = "mortar-slowdown-projectile-stream"

if settings.startup[constants.name_prefix.."enable-ammo-"..ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "bb",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-slowdown-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        custom_tooltip_fields = {
            {
                name = { "strategy-mortar-turret.turret-cooldown-penalty" },
                value = { "seconds", tostring(10) },
            }
        },
        ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1.0,
            cooldown_modifier = 2.0,
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
                            effect_id = "mortar-turret-cooldown-10"
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
            {type = "item", name = "steel-plate", amount = 2},
            {type = "item", name = "grenade", amount = 1},
            {type = "item", name = "slowdown-capsule", amount = 1}
        },
        results = {
            {type = "item", name = ammo_name, amount = 1},
        }
    },
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-slowdown-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "mortar-turret", "military-3" },
        order = "xbb",
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
    },
    common.create_mortar_stream{
        name = projectile_stream_name,
        particle = data.raw["projectile"]["slowdown-capsule"].animation,
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
    },
}