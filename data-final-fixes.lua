local tech = require("script.technology_control")
local constants = require("constants")

-- mortar-cluster-bomb unlock by military-4
tech.remove_unlock_recipe("ironclad", "mortar-cluster-bomb")
if not tech.has_unlock_recipe("military-4", "mortar-cluster-bomb") then
	tech.add_unlock_recipe("military-4", "mortar-cluster-bomb")
end

-- both ironclad and mortar turret unlock basic mortar bomb
if not tech.has_unlock_recipe("ironclad", "mortar-bomb") then
	tech.add_unlock_recipe("ironclad", "mortar-bomb")
end
if not tech.has_unlock_recipe("mortar-turret", "mortar-bomb") then
	tech.add_unlock_recipe("mortar-turret", "mortar-bomb")
end
