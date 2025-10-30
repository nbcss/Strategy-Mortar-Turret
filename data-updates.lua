local tech = require("prototypes.technology_control")
local constants = require("constants")

-- remove ammo recipes from gunboat mod
tech.remove_unlock_recipe("military-3", "mortar-poison-bomb")
tech.remove_unlock_recipe("ironclad", "mortar-fire-bomb")
tech.remove_unlock_recipe("ironclad", "mortar-bomb")
tech.add_prerequisite("ironclad", "mortar-turret")

-- bonus technologies
tech.add_effect("weapon-shooting-speed-3", {type = "gun-speed", ammo_category = constants.mortar_strategy_ammo_category, modifier = 0.2})
tech.add_effect("weapon-shooting-speed-4", {type = "gun-speed", ammo_category = constants.mortar_strategy_ammo_category, modifier = 0.3})
tech.add_effect("weapon-shooting-speed-5", {type = "gun-speed", ammo_category = constants.mortar_strategy_ammo_category, modifier = 0.4})
tech.add_effect("weapon-shooting-speed-6", {type = "gun-speed", ammo_category = constants.mortar_strategy_ammo_category, modifier = 0.6})
