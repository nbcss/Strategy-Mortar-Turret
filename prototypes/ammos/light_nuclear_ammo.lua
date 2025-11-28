local constants = require("constants")
local common = require("prototypes.common")
local sounds = require("__base__.prototypes.entity.sounds")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-light-nuclear-ammo"
local projectile_stream_name = "mortar-light-nuclear-projectile-stream"
local cooldown_penalty = 10

if settings.startup[constants.name_prefix .. "enable-ammo-" .. ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "ac",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-light-nuclear-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        custom_tooltip_fields = {
            {
                name = { "strategy-mortar-turret.turret-cooldown-penalty" },
                value = { "seconds", tostring(cooldown_penalty) },
            }
        },
        ammo_category = "mortar-bomb",
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1.0,
            cooldown_modifier = 1 / 0.4,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = projectile_stream_name,
                        source_offset = source_offset,
                    },
                    {
                        type = "instant",
                        source_effects = {
                            type = "script",
                            effect_id = "mortar-turret-cooldown-" .. cooldown_penalty
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
        energy_required = 15,
        ingredients = {
            { type = "item", name = "steel-plate", amount = 10 },
            { type = "item", name = "explosives",  amount = 10 },
            { type = "item", name = "uranium-235", amount = 20 },
        },
        results = {
            { type = "item", name = ammo_name, amount = 1 },
        }
    },
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-light-nuclear-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "heavy-mortar-turret", "stronger-explosives-4", "kovarex-enrichment-process" },
        order = "xcb",
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "utility-science-pack",    1 },
                { "production-science-pack", 1 },
            },
            time = 30
        },
    },
    common.create_mortar_stream {
        name = projectile_stream_name,
        particle = data.raw["artillery-projectile"]["artillery-projectile"].picture,
        target_position_deviation = 1.0,
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        { -- Destroy cliffs before changing tiles (so the cliff achievement works)
                            type = "destroy-cliffs",
                            radius = 6,
                            explosion_at_trigger = "explosion"
                        },
                        {
                            type = "create-entity",
                            entity_name = "nuke-explosion"
                        },
                        {
                            type = "play-sound",
                            sound = sounds.nuclear_explosion(0.8),
                            play_on_target_position = false,
                            max_distance = 200,
                        },
                        {
                            type = "create-entity",
                            entity_name = "huge-scorchmark",
                            offsets = { { 0, -0.5 } },
                            check_buildability = true
                        },
                        {
                            type = "invoke-tile-trigger",
                            repeat_count = 1
                        },
                        {
                            type = "destroy-decoratives",
                            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                            include_decals = true,
                            invoke_decorative_trigger = true,
                            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                            radius = 8                             -- large radius for demostrative purposes
                        },
                        -- {
                        --     type = "nested-result",
                        --     action =
                        --     {
                        --         type = "area",
                        --         target_entities = false,
                        --         trigger_from_target = true,
                        --         repeat_count = 1000,
                        --         radius = 7,
                        --         action_delivery =
                        --         {
                        --             type = "projectile",
                        --             projectile = "atomic-bomb-ground-zero-projectile",
                        --             starting_speed = 0.6 * 0.8,
                        --             starting_speed_deviation = 0.075,
                        --         }
                        --     }
                        -- },
                    }
                }
            },
            {
                type = "area",
                radius = 3,
                -- force = "enemy",
                action_delivery = {
                    {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                vaporize = true,
                                damage = { type = "explosion", amount = 1000 },
                            }
                        }
                    }
                }
            },
            {
                type = "area",
                radius = 6,
                -- force = "enemy",
                action_delivery = {
                    {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { type = "explosion", amount = 250 },
                            }
                        }
                    }
                }
            },
            {
                type = "area",
                radius = 9,
                -- force = "enemy",
                action_delivery = {
                    {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { type = "explosion", amount = 100 },
                            }
                        }
                    }
                }
            }
        }
    },
}

if mods["space-age"] then
    data.raw["technology"][ammo_name].unit = {
        count = 500,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "military-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 },
            { "space-science-pack",      1 },
        },
        time = 30
    }
end
