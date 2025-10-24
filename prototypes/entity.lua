local sounds = require("__base__/prototypes/entity/sounds")
local constants = require("constants")

data:extend { {
    type = "ammo-turret",
    name = "mortar-turret",
    icon = "__strategy-mortar-turret__/graphics/icons/mortar-turret-icon.png",
    icon_size = 64,
    flags = { "placeable-player", "player-creation", "building-direction-8-way" },
    minable = { mining_time = 0.5, result = "mortar-turret" },
    max_health = 400,
    corpse = "gun-turret-remnants",
    dying_explosion = "gun-turret-explosion",
    collision_box = { { -0.7, -0.7 }, { 0.7, 0.7 } },
    selection_box = { { -1, -1 }, { 1, 1 } },
    --damaged_trigger_effect = hit_effects.entity(),
    rotation_speed = 0.35 / 60,
    preparing_speed = 0.08,
    preparing_sound = sounds.gun_turret_activate,
    folding_sound = sounds.gun_turret_deactivate,
    folding_speed = 0.08,
    inventory_size = 1,
    automated_ammo_count = 10,
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
                shift = util.by_pixel(0, -28),
                animation_speed = 8,
                scale = 0.65
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
                shift = util.by_pixel(0, -28),
                scale = 0.65
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
                shift = util.by_pixel(20, -3.5),
                scale = 0.65
            }
        }
    },
    graphics_set = {
        base_visualisation = {
            animation = {
                layers = {
                    {
                        filename = "__base__/graphics/entity/gun-turret/gun-turret-base.png",
                        priority = "high",
                        width = 150,
                        height = 118,
                        axially_symmetrical = false,
                        direction_count = 1,
                        frame_count = 1,
                        shift = util.by_pixel(0.5, -1),
                        scale = 0.5

                    },
                    {
                        filename = "__base__/graphics/entity/gun-turret/gun-turret-base-mask.png",
                        flags = { "mask", "low-object" },
                        line_length = 1,
                        width = 122,
                        height = 102,
                        axially_symmetrical = false,
                        direction_count = 1,
                        frame_count = 1,
                        shift = util.by_pixel(0, -4.5),
                        apply_runtime_tint = true,
                        scale = 0.5
                    }
                }
            }
        }
    },
    vehicle_impact_sound = sounds.generic_impact,
    attack_parameters = {
        type = "projectile",
        ammo_categories = {"mortar-bomb", constants.mortar_strategy_ammo_category},
        -- lead_target_for_projectile_speed = 0.15,
        cooldown = 600,
        movement_slow_down_factor = 0,
        projectile_creation_distance = 0.5,
        projectile_center = { -0, -0.6 },
        source_direction_count = 8,
        use_shooter_direction = true,
        health_penalty = -1,
        rotate_penalty = 1,
        range = 50,
        min_range = 10,
        turn_range = 0.375,
        sound = sounds.tank_gunshot
    },
    call_for_help_radius = 40,
    water_reflection = {
        pictures = {
            filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
            priority = "extra-high",
            width = 20,
            height = 32,
            shift = util.by_pixel(0, 40),
            variation_count = 1,
            scale = 5
        },
        rotate = false,
        orientation_to_variation = false
    },
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions.create_vector(
        universal_connector_template, {
            { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
            { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
            { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
            { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
            { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
            { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
            { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
            { variation = 17, main_offset = util.by_pixel( -21, 1), shadow_offset = util.by_pixel( -12, 10), show_shadow = true },
        }
    ),
} }
