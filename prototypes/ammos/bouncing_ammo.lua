local constants = require("constants")
local common = require("prototypes.common")
local sounds = require("__base__.prototypes.entity.sounds")
local tech = require("technology_tool")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-bouncing-ammo"
local projectile_stream_name = "mortar-bouncing-projectile-stream"

-- if settings.startup[constants.name_prefix .. "enable-ammo-" .. ammo_name].value == false then
--     return
-- end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "ba",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-shrapnel-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        ammo_category = constants.physical_mortar_ammo_category,
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
                        source_offset = source_offset,
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
        target_position_deviation = 0.1,
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
                type = "direct",
                probability = 0.75,
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "script",
                        effect_id = "mortar-bouncing"
                    }
                }
            },
        }
    },
}

