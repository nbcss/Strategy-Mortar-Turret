local tech = require("script.technology_control")
local constants = require("constants")

-- craft recipes
tech.add_unlock_recipe("military-3", constants.slowdown_ammo)
tech.add_unlock_recipe("defender", constants.defender_ammo)
tech.add_unlock_recipe("distractor", constants.distractor_ammo)
tech.add_unlock_recipe("destroyer", constants.destroyer_ammo)
tech.add_unlock_recipe("discharge-defense-equipment", constants.energy_ammo)
tech.add_unlock_recipe("military-4", constants.heavy_ammo)

-- bonus technologies
tech.add_effect("weapon-shooting-speed-3", {type = "gun-speed", ammo_category = constants.mortar_strategy_ammo_category, modifier = 0.2})
tech.add_effect("weapon-shooting-speed-4", {type = "gun-speed", ammo_category = constants.mortar_strategy_ammo_category, modifier = 0.3})
tech.add_effect("weapon-shooting-speed-5", {type = "gun-speed", ammo_category = constants.mortar_strategy_ammo_category, modifier = 0.4})
tech.add_effect("weapon-shooting-speed-6", {type = "gun-speed", ammo_category = constants.mortar_strategy_ammo_category, modifier = 0.6})
