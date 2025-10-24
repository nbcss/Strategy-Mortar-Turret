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

if settings.startup[constants.name_prefix .. "remove-aai-ironclad"].value == true then
    data.raw["car"]["ironclad"] = nil
    data.raw["item-with-entity-data"]["ironclad"] = nil
    data.raw["recipe"]["ironclad"] = nil
    data.raw["recipe"]["ironclad-recycling"] = nil
    data.raw["technology"]["ironclad"] = nil
    for _, technology in pairs(data.raw.technology) do
        if technology.prerequisites then
            for index, prerequisite in pairs(technology.prerequisites) do
                if prerequisite == "ironclad" then
                    table.remove(technology.prerequisites, index)
                    break
                end
            end
        end
    end
end
