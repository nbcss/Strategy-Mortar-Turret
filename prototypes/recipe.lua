local constants = require("constants")

data.extend{
    {
        type = "recipe",
        name = "mortar-turret",
        subgroup = "turret",
        order = "b[turret]-a[gun-turret]",
        enabled = false,
        energy_required = 5,
        ingredients = {
            {type = "item", name = "engine-unit", amount = 5},
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "iron-gear-wheel", amount = 10},
        },
        results = {
            {type = "item", name = "mortar-turret", amount = 1},
        }
    },
    {
        type = "recipe",
        name = constants.poison_ammo,
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 2},
            {type = "item", name = "grenade", amount = 1},
            {type = "item", name = "poison-capsule", amount = 1}
        },
        results = {
            {type = "item", name = constants.poison_ammo, amount = 1},
        }
    },
    {
        type = "recipe",
        name = constants.slowdown_ammo,
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 2},
            {type = "item", name = "grenade", amount = 1},
            {type = "item", name = "slowdown-capsule", amount = 1}
        },
        results = {
            {type = "item", name = constants.slowdown_ammo, amount = 1},
        }
    },
    {
        type = "recipe",
        name = constants.fire_ammo,
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 2},
            {type = "item", name = "grenade", amount = 1},
            {type = "item", name = "flamethrower-ammo", amount = 1}
        },
        results = {
            {type = "item", name = constants.fire_ammo, amount = 1},
        }
    },
    {
        type = "recipe",
        name = constants.defender_ammo,
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "iron-plate", amount = 5},
            {type = "item", name = "electronic-circuit", amount = 3},
            {type = "item", name = "defender-capsule", amount = 1}
        },
        results = {
            {type = "item", name = constants.defender_ammo, amount = 1},
        }
    },
    {
        type = "recipe",
        name = constants.distractor_ammo,
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "advanced-circuit", amount = 2},
            {type = "item", name = "distractor-capsule", amount = 1}
        },
        results = {
            {type = "item", name = constants.distractor_ammo, amount = 1},
        }
    },
    {
        type = "recipe",
        name = constants.destroyer_ammo,
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "low-density-structure", amount = 2},
            {type = "item", name = "processing-unit", amount = 1},
            {type = "item", name = "destroyer-capsule", amount = 1}
        },
        results = {
            {type = "item", name = constants.destroyer_ammo, amount = 1},
        }
    },
    {
        type = "recipe",
        name = constants.energy_ammo,
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 5},
            {type = "item", name = "plastic-bar", amount = 5},
            {type = "item", name = "battery", amount = 10}
        },
        results = {
            {type = "item", name = constants.energy_ammo, amount = 1},
        }
    },
    {
        type = "recipe",
        name = constants.heavy_ammo,
        enabled = false,
        energy_required = 8,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 15},
            {type = "item", name = "explosives", amount = 5},
            {type = "item", name = "advanced-circuit", amount = 2}
        },
        results = {
            {type = "item", name = constants.heavy_ammo, amount = 1},
        }
    },
}