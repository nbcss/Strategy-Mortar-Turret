local sounds = require("__base__/prototypes/entity/sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")
local constants = require("constants")

data:extend {
    {
        type = "item",
        name = "heavy-mortar-turret",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-turret-icon.png",
        icon_size = 64,
        subgroup = "turret",
        order = "b[turret]-a[gun-turret]-b",
        place_result = "heavy-mortar-turret",
        stack_size = 5,
    },
    {
        type = "recipe",
        name = "heavy-mortar-turret",
        subgroup = "turret",
        enabled = false,
        energy_required = 30,
        ingredients = {
            { type = "item", name = "electric-engine-unit", amount = 10 },
            { type = "item", name = "processing-unit",      amount = 10 },
            { type = "item", name = "steel-plate",          amount = 30 },
            { type = "item", name = "iron-gear-wheel",      amount = 50 },
        },
        results = {
            { type = "item", name = "heavy-mortar-turret", amount = 1 },
        }
    },
    {
        type = "technology",
        name = "heavy-mortar-turret",
        icon_size = 256,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-turret.png",
        effects = {
            { type = "unlock-recipe", recipe = "heavy-mortar-turret" },
        },
        prerequisites = { "mortar-turret", "military-4" },
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "utility-science-pack",    1 },
            },
            time = 30
        },
        order = "y",
    },
    {
        type = "ammo-turret",
        name = "heavy-mortar-turret",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-turret-icon.png",
        icon_size = 64,
        flags = { "placeable-player", "player-creation" },
        minable = { mining_time = 1.0, result = "heavy-mortar-turret" },
        max_health = 1600,
        corpse = "medium-remnants",
        dying_explosion = "gun-turret-explosion",
        collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
        selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
        damaged_trigger_effect = hit_effects.entity(),
        rotation_speed = 0.1 / 60,
        preparing_speed = 0.08,
        preparing_sound = sounds.gun_turret_activate,
        folding_sound = sounds.gun_turret_deactivate,
        folding_speed = 0.08,
        inventory_size = 1,
        automated_ammo_count = 5,
        alert_when_attacking = true,
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        turret_base_has_direction = true,
        folded_animation = {
            layers = {
                {
                    filename = "__aai-vehicles-ironclad__/graphics/entity/mortar-turret/mortar-turret.png",
                    priority = "low",
                    line_length = 16,
                    width = 2048 / 16,
                    height = 448 / 4,
                    frame_count = 1,
                    direction_count = 64,
                    shift = util.by_pixel(0, -26),
                    animation_speed = 8,
                    scale = 0.82,
                },
                {
                    filename = "__aai-vehicles-ironclad__/graphics/entity/mortar-turret/mortar-turret-mask.png",
                    priority = "low",
                    line_length = 16,
                    width = 2048 / 16,
                    height = 448 / 4,
                    frame_count = 1,
                    apply_runtime_tint = true,
                    direction_count = 64,
                    shift = util.by_pixel(0, -26),
                    scale = 0.82,
                },
                {
                    filename = "__aai-vehicles-ironclad__/graphics/entity/mortar-turret/mortar-turret-shadow.png",
                    priority = "low",
                    line_length = 4,
                    width = 672 / 4,
                    height = 1472 / 16,
                    frame_count = 1,
                    draw_as_shadow = true,
                    direction_count = 64,
                    shift = util.by_pixel(30, -5),
                    scale = 0.82,
                }
            }
        },
        graphics_set = {
            base_visualisation = {
                animation = {
                    layers = {
                        {
                            filename = "__strategy-mortar-turret__/graphics/entity/large-turret-base.png",
                            width = 202,
                            height = 168,
                            line_length = 1,
                            priority = "high",
                            frame_count = 1,
                            scale = 0.5,
                            shift = util.by_pixel(-0.5, 4.5),
                        },
                        {
                            filename = "__strategy-mortar-turret__/graphics/entity/large-turret-base-mask.png",
                            width = 170,
                            height = 148,
                            line_length = 1,
                            flags = { "mask", "low-object" },
                            frame_count = 1,
                            apply_runtime_tint = true,
                            scale = 0.5,
                            shift = util.by_pixel(0.0, 1.0),
                        },
                        {
                            filename = "__strategy-mortar-turret__/graphics/entity/large-turret-base-shadow.png",
                            width = 204,
                            height = 148,
                            line_length = 1,
                            frame_count = 1,
                            scale = 0.5,
                            shift = util.by_pixel(7.5, 6.5),
                            draw_as_shadow = true,
                        },
                    }
                }
            }
        },
        vehicle_impact_sound = sounds.generic_impact,
        attack_parameters = {
            type = "projectile",
            ammo_categories = { constants.mortar_strategy_ammo_category, "mortar-bomb" },
            damage_modifier = 1.6,
            lead_target_for_projectile_speed = 0.4,
            cooldown = 15 * 60,
            movement_slow_down_factor = 0,
            projectile_creation_distance = 0.8,
            projectile_center = { -0, -0.8 },
            health_penalty = 0,
            rotate_penalty = 10,
            range = 90,
            min_range = 25,
            turn_range = 0.3,
            sound = sounds.tank_gunshot
        },
        call_for_help_radius = 40,
        water_reflection = {
            pictures = {
                filename = "__base__/graphics/entity/artillery-turret/artillery-turret-reflection.png",
                priority = "extra-high",
                width = 28,
                height = 32,
                shift = util.by_pixel(0, 75),
                variation_count = 1,
                scale = 5
            },
            rotate = false,
            orientation_to_variation = false
        },
        circuit_wire_max_distance = default_circuit_wire_max_distance,
        circuit_connector = circuit_connector_definitions.create_vector(
            universal_connector_template, {
                { variation = 17, main_offset = util.by_pixel( -18, 13), shadow_offset = util.by_pixel( -12, 25), show_shadow = false },
                { variation = 17, main_offset = util.by_pixel( -18, 13), shadow_offset = util.by_pixel( -12, 25), show_shadow = false },
                { variation = 17, main_offset = util.by_pixel( -18, 13), shadow_offset = util.by_pixel( -12, 25), show_shadow = false },
                { variation = 17, main_offset = util.by_pixel( -18, 13), shadow_offset = util.by_pixel( -12, 25), show_shadow = false },
            }
        ),
    },
}
