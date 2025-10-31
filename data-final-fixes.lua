local tech = require("prototypes.technology_control")
local constants = require("constants")

-- update ironclad explosive prerequisites
tech.remove_prerequisite("ironclad", "explosives")
if data.raw["recipe"]["mortar-bomb"] then
    data.raw["recipe"]["mortar-bomb"].ingredients = {
        { type = "item", name = "steel-plate", amount = 2 },
        { type = "item", name = "grenade",     amount = 2 },
    }
end

-- dedicated mortar-cluster-bomb tech
tech.remove_unlock_recipe("ironclad", "mortar-cluster-bomb")
tech.remove_unlock_recipe("military-4", "mortar-cluster-bomb")
data.extend {
    {
        type = "technology",
        name = "mortar-cluster-bomb",
        icon = "__aai-vehicles-ironclad__/graphics/icons/mortar-cluster-bomb.png",
        icon_size = 64,
        effects = {
            { type = "unlock-recipe", recipe = "mortar-cluster-bomb" },
        },
        prerequisites = { "mortar-turret", "military-4" },
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
                { "military-science-pack",   1 },
                { "chemical-science-pack",   1 },
                { "utility-science-pack",    1 },
            },
            time = 30
        },
        order = "e-c-c"
    },
}

-- remove damage alerts for enemies to avoid hypnosis alert spam
if settings.startup[constants.name_prefix .. "enable-ammo-mortar-hypnosis-ammo"].value == true then
    for _, unit in pairs(data.raw["unit"]) do
        local subgroup = data.raw["item-subgroup"][unit.subgroup]
        if subgroup.group == "enemies" then
            unit.alert_when_damaged = false
        end
    end
end

-- remove AAI ironclad in startup
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
