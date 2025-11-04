local constants = require("constants")
local common = require("prototypes.common")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-lure-robot-ammo"
local projectile_stream_name = "mortar-lure-robot-projectile-stream"
local detonation_damage = 50
local tint_color = { 0.94, 0.14, 0.14, 1.0 }

if settings.startup[constants.name_prefix .. "enable-ammo-" .. ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "dd",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-lure-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        custom_tooltip_fields = {
            {
                name = { "strategy-mortar-turret.detonation-damage" },
                value = { "", tostring(detonation_damage), " ", { "damage-type-name.explosion" } },
            },
        },
        ammo_category = constants.mortar_strategy_ammo_category,
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1.0,
            cooldown_modifier = 1 / 0.75,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = projectile_stream_name,
                        source_offset = source_offset
                    },
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
            { type = "item", name = "steel-plate",                amount = 3 },
            { type = "item", name = "explosives",                 amount = 1 },
            { type = "item", name = "mortar-defender-robot-ammo", amount = 1 }
        },
        results = {
            { type = "item", name = ammo_name, amount = 1 },
            -- {type = "item", name = "piercing-rounds-magazine", amount = 3},  --refund ammo?
        }
    },
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-lure-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "mortar-defender-robot-ammo", "explosives" },
        order = "xdd",
        unit = {
            count = 150,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
            },
            time = 30
        },
    },
    common.create_mortar_stream {
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
                        entity_name = "deployed-lure-robot",
                        -- offsets = { { 1, -1 }, { -1, -1 }, { 0, 1 } }
                    },
                    -- {
                    --     type = "create-entity",
                    --     show_in_tooltip = true,
                    --     entity_name = "lure-dummy-detonation",
                    -- }
                }
            }
        }
    },
    util.merge { data.raw["combat-robot"]["defender"], {
        name = "deployed-lure-robot",
        max_health = 600,
        follows_player = false,
        speed = 0,
        max_speed = 0,
        time_to_live = 60 * 4, --reduced TTL
        hidden = true,
        hidden_in_factoriopedia = true,
        localised_name = { "entity-name.deployed-lure-robot" },
        resistances =
        {
            {
                type = "fire",
                percent = 95
            },
            {
                type = "acid",
                decrease = 0,
                percent = 80
            },
            {
                type = "physical",
                decrease = 0,
                percent = 80
            }
        },
        attack_parameters = {
            type = "projectile",
            cooldown = 60,
            damage_modifier = 0.2,
        },
        idle = {
            layers = {
                {
                    filename = "__base__/graphics/entity/defender-robot/defender-robot.png",
                    priority = "high",
                    line_length = 16,
                    width = 56,
                    height = 59,
                    direction_count = 16,
                    shift = util.by_pixel(0, 0.25),
                    scale = 0.5,
                    tint = tint_color,
                },
                {
                    filename = "__base__/graphics/entity/defender-robot/defender-robot-mask.png",
                    priority = "high",
                    line_length = 16,
                    width = 28,
                    height = 21,
                    direction_count = 16,
                    shift = util.by_pixel(0, -4.75),
                    apply_runtime_tint = true,
                    scale = 0.5,
                    tint = tint_color,
                }
            }
        },
        destroy_action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                source_effects = {
                    {
                        type = "create-entity",
                        entity_name = "defender-robot-explosion"
                    },
                    {
                        type = "create-entity",
                        entity_name = "grenade-explosion"
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
                        type = "nested-result",
                        action = {
                            type = "area",
                            radius = 5,
                            force = "enemy",
                            action_delivery = {
                                {
                                    type = "instant",
                                    target_effects = {
                                        {
                                            type = "damage",
                                            damage = { type = "explosion", amount = detonation_damage },
                                        }
                                    }
                                }
                            }
                        },
                    }
                }
            }
        },
    } },
    -- common.replace_merge { data.raw["land-mine"]["land-mine"], {
    --     name = "lure-dummy-detonation",
    --     minable = common.nil_value,
    --     hidden = true,
    --     hidden_in_factoriopedia = true,
    --     action = {
    --         type = "area",
    --         radius = 5,
    --         force = "enemy",
    --         action_delivery = {
    --             {
    --                 type = "instant",
    --                 target_effects = {
    --                     {
    --                         type = "damage",
    --                         damage = { type = "explosion", amount = detonation_damage },
    --                     }
    --                 }
    --             }
    --         }
    --     },
    -- } },
}
