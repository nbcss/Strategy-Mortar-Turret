local tech = require("technology_tool")
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

-- rebalance ironclad mortar shooting speed
data.raw["gun"]["ironclad-mortar"].attack_parameters.cooldown = 460
data.raw["ammo"]["mortar-bomb"].ammo_type.cooldown_modifier = 1 / 3.0
data.raw["ammo"]["mortar-cluster-bomb"].ammo_type.cooldown_modifier = 1 / 2.5
for tech_name, _ in pairs(data.raw.technology) do
    tech.remove_effect(tech_name, function(effect)
        return effect.type == "gun-speed" and effect.ammo_category == "mortar-bomb"
    end)
end
tech.add_effect("weapon-shooting-speed-3", { type = "gun-speed", ammo_category = "mortar-bomb", modifier = 0.4 })
tech.add_effect("weapon-shooting-speed-4", { type = "gun-speed", ammo_category = "mortar-bomb", modifier = 0.6 })
tech.add_effect("weapon-shooting-speed-5", { type = "gun-speed", ammo_category = "mortar-bomb", modifier = 0.8 })
tech.add_effect("weapon-shooting-speed-6", { type = "gun-speed", ammo_category = "mortar-bomb", modifier = 1.0 })

-- remove damage alerts for enemies to avoid hypnosis alert spam
if settings.startup[constants.name_prefix .. "enable-ammo-mortar-hypnosis-ammo"].value == true then
    for _, unit in pairs(data.raw["unit"]) do
        if unit.subgroup then
            local subgroup = data.raw["item-subgroup"][unit.subgroup]
            if subgroup.group == "enemies" then
                unit.alert_when_damaged = false
            end
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

if settings.startup[constants.name_prefix .. "reduce-mortar-ammo-stack-size"].value == true then
    data.raw["ammo"]["mortar-bomb"].stack_size = 25
    data.raw["ammo"]["mortar-cluster-bomb"].stack_size = 25
    for _, ammo_name in ipairs(constants.ammo_types) do
        if data.raw["ammo"][ammo_name] then
            data.raw["ammo"][ammo_name].stack_size = 25
        end
    end
end

if settings.startup[constants.name_prefix .. "cheap-ammo-mode"].value == true then
    data.raw["recipe"]["mortar-bomb"].results[1].amount = 2
    data.raw["recipe"]["mortar-cluster-bomb"].results[1].amount = 2
    for _, ammo_name in ipairs(constants.ammo_types) do
        if data.raw["recipe"][ammo_name] then
            data.raw["recipe"][ammo_name].results[1].amount = 2
        end
    end
end
