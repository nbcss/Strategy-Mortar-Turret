local tech = require("prototypes.technology_control")
local constants = require("constants")

-- update ironclad explosive prerequisites
tech.remove_prerequisite("ironclad", "explosives")
if data.raw["recipe"]["mortar-bomb"] then
    for index, ingredent in ipairs(data.raw["recipe"]["mortar-bomb"].ingredients) do
        if ingredent.type == "item" and ingredent.name == "explosives" then
            table.remove(data.raw["recipe"]["mortar-bomb"].ingredients, index)
            break
        end
    end
end

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

if settings.startup[constants.name_prefix .. "remove-aai-ironclad"].value == true then
    data.raw["car"]["ironclad"] = nil
    data.raw["item-with-entity-data"]["ironclad"] = nil
    data.raw["recipe"]["ironclad"] = nil
    data.raw["recipe"]["ironclad-recycling"] = nil
    data.raw["technology"]["ironclad"] = nil
    for _, technology in pairs(data.raw.technology) do
        tech.remove_prerequisite(technology, "ironclad")
    end
end
