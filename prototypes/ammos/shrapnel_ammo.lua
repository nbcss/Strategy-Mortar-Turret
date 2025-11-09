local constants = require("constants")
local common = require("prototypes.common")
local sounds = require("__base__.prototypes.entity.sounds")
local tech = require("technology_tool")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-shrapnel-ammo"
local projectile_stream_name = "mortar-shrapnel-projectile-stream"

if settings.startup[constants.name_prefix .. "enable-ammo-" .. ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "ac",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-shrapnel-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        ammo_category = "mortar-bomb",
        ammo_type = {
            target_type = "position",
            clamp_position = true,
            range_modifier = 1.0,
            cooldown_modifier = 1 / 2.5,
            action = {
                type = "direct",
                action_delivery = {
                    {
                        type = "stream",
                        stream = projectile_stream_name,
                        source_offset = source_offset
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
            { type = "item", name = "steel-plate",   amount = 2 },
            { type = "item", name = "grenade",       amount = 1 },
            { type = "item", name = "shotgun-shell", amount = 1 },
        },
        results = {
            { type = "item", name = ammo_name, amount = 1 },
        }
    },
    common.create_mortar_stream {
        name = projectile_stream_name,
        particle = data.raw["projectile"]["grenade"].animation,
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
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
                    }
                }
            },
            {
                type = "area",
                radius = 2.5,
                force = "enemy",
                show_in_tooltip = true,
                action_delivery = {
                    {
                        type = "instant",
                        target_effects = {
                            {
                                type = "damage",
                                damage = { type = "explosion", amount = 30 },
                            }
                        }
                    }
                }
            },
            {
                type = "area",
                radius = 0.5,
                show_in_tooltip = true,
                trigger_from_target = true,
                target_entities = false,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "nested-result",
                            action = {
                                type = "direct",
                                repeat_count = 120,
                                action_delivery = {
                                    type = "projectile",
                                    projectile = "shotgun-pellet",
                                    starting_speed = 1,
                                    starting_speed_deviation = 0.1,
                                    direction_deviation = 6.28,
                                    range_deviation = 0.1,
                                    max_range = 6,
                                }
                            }
                        },
                        {
                            type = "play-sound",
                            sound = sounds.shotgun,
                        },
                    }
                }
            },
        }
    },
}

-- unlock by mortar turret (base ammo)
tech.add_unlock_recipe("mortar-turret", ammo_name)
