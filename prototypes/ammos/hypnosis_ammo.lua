local constants = require("constants")
local common = require("prototypes.common")
local tech = require("technology_tool")
local hypnosis_control = require("script.hypnosis_control")
local source_offset = { 0, 0.25 }
local ammo_name = "mortar-hypnosis-ammo"
local projectile_stream_name = "mortar-hypnosis-projectile-stream"
local tint_color = { 0.788, 0.278, 1.000, 0.694 }

if settings.startup[constants.name_prefix .. "enable-ammo-" .. ammo_name].value == false then
    return
end

data:extend {
    {
        type = "ammo",
        name = ammo_name,
        order = "de",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-hypnosis-ammo.png",
        icon_size = 64,
        subgroup = constants.mortar_ammo_subgroup,
        stack_size = 200,
        custom_tooltip_fields = {
            {
                name = { "strategy-mortar-turret.hypnosis-duration" },
                value = { "seconds", tostring(hypnosis_control.hypnosis_time) },
            },
            {
                name = { "strategy-mortar-turret.hypnosis-max-chance" },
                value = { "format-percent", tostring(hypnosis_control.max_chance * 100) },
            }
        },
        ammo_category = constants.strategy_mortar_ammo_category,
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
                    }
                }
            }
        }
    },
    {
        type = "recipe",
        name = ammo_name,
        enabled = false,
        energy_required = 10,
        ingredients = {
            { type = "item", name = "processing-unit",    amount = 1 },
            { type = "item", name = "uranium-235",        amount = 1 },
            { type = "item", name = "mortar-poison-bomb", amount = 1 },
        },
        results = {
            { type = "item", name = ammo_name, amount = 1 },
        }
    },
    {
        type = "technology",
        name = ammo_name,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-hypnosis-ammo.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = ammo_name },
        },
        prerequisites = { "mortar-turret", "effect-transmission", "uranium-processing", "military-3" },
        order = "xbe",
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "production-science-pack", 1 },
            },
            time = 30
        },
    },
    common.create_mortar_stream {
        name = projectile_stream_name,
        particle = table.deepcopy(data.raw["projectile"]["poison-capsule"].animation),
        action = {
            {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "create-particle",
                        particle_name = "poison-capsule-metal-particle",
                        repeat_count = 8,
                        tint = tint_color,
                        initial_height = 1,
                        initial_vertical_speed = 0.1,
                        initial_vertical_speed_deviation = 0.05,
                        offset_deviation = { { -0.1, -0.1 }, { 0.1, 0.1 } },
                        speed_from_center = 0.05,
                        speed_from_center_deviation = 0.01
                    }
                }
            },
            {
                type = "area",
                radius = 8,
                force = "enemy",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        type = "script",
                        effect_id = "mortar-apply-hypnosis",
                        show_in_tooltip = true
                    }
                }
            }
        }
    },
    {
        type = "sticker",
        name = "hypnosis-sticker",
        hidden = true,
        duration_in_ticks = 99999999,
        target_movement_modifier = 0.8,
        animation = {
            filename = "__base__/graphics/entity/slowdown-sticker/slowdown-sticker.png",
            line_length = 5,
            width = 42,
            height = 48,
            frame_count = 50,
            animation_speed = 0.5,
            tint = tint_color,
            shift = util.by_pixel(2, -0.5),
            scale = 0.5
        },
        update_effects = {
            {
                time_cooldown = 10,
                initial_time_cooldown = hypnosis_control.hypnosis_time * 60,
                effect = {
                    type = "script",
                    effect_id = "mortar-kill-unit",
                },
            },
        }
    },
    {
        type = "ammo-category",
        name = "mortar-hypnosis-effect",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-hypnosis-ammo.png",
        icon_size = 64,
        subgroup = "ammo-category",
        hidden = true,
    },
}

data.raw["stream"][projectile_stream_name].particle.tint = tint_color

if settings.startup[constants.name_prefix .. "enable-ammo-mortar-poison-bomb"].value == true then
    tech.add_prerequisite(ammo_name, "mortar-poison-bomb")
end
-- add bonus tech effects
for level = 1, 4 do
    tech.add_effect("strategy-mortar-shell-efficiency-" .. level, {
        type = "ammo-damage",
        ammo_category = "mortar-hypnosis-effect",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-hypnosis-ammo.png",
        icon_size = 64,
        modifier = 0.2 + 0.2 * level,
    })
end
if mods["space-age"] then
    -- todo update recipe & tech
end
