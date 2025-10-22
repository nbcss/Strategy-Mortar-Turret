data.extend{
    {
        type = "recipe",
        name = "mortar-energy-ammo",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-energy-ammo.png",
        icon_size = 64,
        subgroup = "ammo",
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "plastic-bar", amount = 5},
            {type = "item", name = "battery", amount = 10}
        },
        results = {
            {type = "item", name = "mortar-energy-ammo", amount = 1},
        }
    },
    {
        type = "recipe",
        name = "mortar-slowdown-ammo",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-slowdown-ammo.png",
        icon_size = 64,
        subgroup = "ammo",
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 2},
            {type = "item", name = "grenade", amount = 1},
            {type = "item", name = "slowdown-capsule", amount = 1}
        },
        results = {
            {type = "item", name = "mortar-slowdown-ammo", amount = 1},
        }
    },
    {
        type = "recipe",
        name = "mortar-heavy-ammo",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-heavy-ammo.png",
        icon_size = 64,
        subgroup = "ammo",
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 15},
            {type = "item", name = "explosives", amount = 5},
            {type = "item", name = "advanced-circuit", amount = 2}
        },
        results = {
            {type = "item", name = "mortar-heavy-ammo", amount = 1},
        }
    },
    {
        type = "recipe",
        name = "mortar-defender-robot-ammo",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-defender-ammo.png",
        icon_size = 64,
        subgroup = "ammo",
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "iron-plate", amount = 5},
            {type = "item", name = "electronic-circuit", amount = 3},
            {type = "item", name = "defender-capsule", amount = 1}
        },
        results = {
            {type = "item", name = "mortar-defender-robot-ammo", amount = 1},
        }
    },
    {
        type = "recipe",
        name = "mortar-distractor-robot-ammo",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-distractor-ammo.png",
        icon_size = 64,
        subgroup = "ammo",
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "advanced-circuit", amount = 2},
            {type = "item", name = "distractor-capsule", amount = 1}
        },
        results = {
            {type = "item", name = "mortar-distractor-robot-ammo", amount = 1},
        }
    },
    {
        type = "recipe",
        name = "mortar-destroyer-robot-ammo",
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-destroyer-ammo.png",
        icon_size = 64,
        subgroup = "ammo",
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "low-density-structure", amount = 2},
            {type = "item", name = "processing-unit", amount = 1},
            {type = "item", name = "destroyer-capsule", amount = 1}
        },
        results = {
            {type = "item", name = "mortar-destroyer-robot-ammo", amount = 1},
        }
    }
}