local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-energy-ammo"
local projectile_stream_name = "mortar-energy-projectile-stream"

if settings.startup[constants.name_prefix.."enable-ammo-"..ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "ca",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-energy-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        ammo_category = constants.strategy_mortar_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1,
            cooldown_modifier = 1 / 0.75,
            action = {
                type = "direct",
                action_delivery = {
                    type = "stream",
                    stream = projectile_stream_name,
                    source_offset = source_offset
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
            {type = "item", name = "plastic-bar", amount = 5},
            {type = "item", name = "battery", amount = 10}
        },
        results = {
            {type = "item", name = ammo_name, amount = 1},
        }
    },
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-energy-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "mortar-turret", "discharge-defense-equipment" },
        order = "xca",
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
        -- TODO add particle
        particle = data.raw["artillery-projectile"]["artillery-projectile"].picture,
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
                            entity_name = "small-scorchmark-tintable",
                            check_buildability = true
                        },
                        {
                            type = "invoke-tile-trigger",
                            repeat_count = 1
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
    },
    common.replace_merge{ data.raw["beam"]["electric-beam"], {
        name = "electric-beam-no-damage",
        action = common.nil_value,
    } },
    {
        type = "combat-robot",
        name = "mortar-turret-electric-effect",
        attack_parameters = {
            type = "projectile",
            cooldown = 10000000,
            range = 0,
            damage_modifier = 0,
            ammo_type = {},
            ammo_category = "bullet"
        },
        follows_player = false,
        flags = { "not-on-map", "not-blueprintable", "not-selectable-in-game", "not-deconstructable" },
        hidden = true,
        speed = 0,
        max_speed = 0,
        time_to_live = 60 * 2,
        max_health = 10000000,
        alert_when_damaged = false,
        is_military_target = false,
        created_effect = {
            {
                type = "area",
                radius = 6,
                force = "enemy",
                action_delivery =
                {
                    {
                        type = "instant",
                        target_effects =
                        {
                            {
                                type = "create-sticker",
                                sticker = "stun-sticker"
                            },
                            {
                                type = "push-back",
                                distance = 2
                            }
                        }
                    },
                    {
                        type = "beam",
                        beam = "electric-beam-no-damage",
                        max_length = 8,
                        duration = 60,
                        source_offset = { 0, -0.5 },
                        add_to_shooter = false
                    }
                }
            }
        },
    },
}