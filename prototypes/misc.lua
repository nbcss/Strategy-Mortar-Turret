local constants = require("constants")
local common = require("prototypes.common")

data.extend {
    {
        type = "ammo-category",
        name = constants.strategy_mortar_ammo_category,
        icon = "__aai-vehicles-ironclad__/graphics/icons/mortar-bomb-ammo-category.png",
        subgroup = "ammo-category",
        bonus_gui_order = "sma-a",
    },
    {
        type = "ammo-category",
        name = constants.physical_mortar_ammo_category,
        icon = "__aai-vehicles-ironclad__/graphics/icons/mortar-bomb-ammo-category.png",
        subgroup = "ammo-category",
        bonus_gui_order = "sma-b",
        -- hidden_in_factoriopedia = true,
    },
    {
        type = "ammo-category",
        name = constants.electric_mortar_ammo_category,
        icon = "__aai-vehicles-ironclad__/graphics/icons/mortar-bomb-ammo-category.png",
        subgroup = "ammo-category",
        bonus_gui_order = "sma-c",
        -- hidden_in_factoriopedia = true,
    },
    {
        type = "item-subgroup",
        name = constants.mortar_ammo_subgroup,
        group = "combat",
        order = "b-a"
    },
    {
        type = "combat-robot",
        name = "mortar-turret-robot-locator",
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
        time_to_live = 60 * 60,
        max_health = 10000000,
        alert_when_damaged = false,
        is_military_target = false,
        created_effect = common.robot_deploy_effect(),
    },
}
