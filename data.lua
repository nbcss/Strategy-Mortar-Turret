local constants = require("constants")

-- mortar turret
require("prototypes.mortar_turret")
require("prototypes.heavy_mortar_turret")
-- tech & misc
require("prototypes.technology")
require("prototypes.misc")
-- ammos
require("prototypes.ammos.poison_ammo")
require("prototypes.ammos.slowdown_ammo")
require("prototypes.ammos.fire_ammo")
require("prototypes.ammos.defender_robot_ammo")
require("prototypes.ammos.distractor_robot_ammo")
require("prototypes.ammos.destroyer_robot_ammo")
require("prototypes.ammos.lure_robot_ammo")
require("prototypes.ammos.energy_ammo")
require("prototypes.ammos.heavy_ammo")
require("prototypes.ammos.illumination_ammo")
require("prototypes.ammos.hypnosis_ammo")
require("prototypes.ammos.shrapnel_ammo")
require("prototypes.ammos.light_nuclear_ammo")
-- require("prototypes.ammos.bouncing_ammo")

-- change to 360 angle turret
if settings.startup[constants.name_prefix .. "directional-turret-range"].value == false then
    local turret = data.raw["ammo-turret"]["mortar-turret"]
    turret.attack_parameters.turn_range = nil
end

-- update ironclad turret to use strategy ammo
local ironclad_mortar_turret = data.raw["gun"]["ironclad-mortar"]
ironclad_mortar_turret.attack_parameters.ammo_category = nil
ironclad_mortar_turret.attack_parameters.ammo_categories = { "mortar-bomb",
    constants.strategy_mortar_ammo_category,
    constants.physical_mortar_ammo_category,
    constants.electric_mortar_ammo_category,
}

-- rearrange item group
local mortar_bomb_ammo_item = data.raw["ammo"]["mortar-bomb"]
mortar_bomb_ammo_item.subgroup = constants.mortar_ammo_subgroup
mortar_bomb_ammo_item.order = "aa"

local mortar_cluster_bomb_ammo_item = data.raw["ammo"]["mortar-cluster-bomb"]
mortar_cluster_bomb_ammo_item.subgroup = constants.mortar_ammo_subgroup
mortar_cluster_bomb_ammo_item.order = "ab"

-- Ago of Production dependency
if mods["Age-of-Production"] then
    -- 2.1 replaced recipe.category/additional_categories with a categories array;
    -- append "ammunition" while keeping the recipe's original category.
    local function add_ammunition_category(recipe_name)
        local recipe = data.raw["recipe"][recipe_name]
        if not recipe then return end
        recipe.categories = recipe.categories or { recipe.category or "crafting" }
        recipe.category = nil
        table.insert(recipe.categories, "ammunition")
    end
    -- AAI base mortar bombs update
    add_ammunition_category("mortar-bomb")
    add_ammunition_category("mortar-cluster-bomb")
    -- strategy ammos update
    for _, ammo_name in ipairs(constants.ammo_types) do
        add_ammunition_category(ammo_name)
    end
end

-- Update gunshot effect
local function add_gunshot_effect(ammo_prototype)
    local action_delivery = ammo_prototype.ammo_type.action.action_delivery[1] or ammo_prototype.ammo_type.action.action_delivery
    local source_effects = action_delivery.source_effects or {}
    table.insert(source_effects, {
        type = "create-explosion",
        -- entity_name = "explosion-gunshot",
        -- offsets = { { 0, 0.5 } },
        entity_name = "mortar-muzzle-flash",
        offsets = { { 0, -0.65 } },
    })
    action_delivery.source_effects = source_effects
end
add_gunshot_effect(data.raw["ammo"]["mortar-bomb"])
add_gunshot_effect(data.raw["ammo"]["mortar-cluster-bomb"])
for _, ammo_name in ipairs(constants.ammo_types) do
    if data.raw["ammo"][ammo_name] then
        add_gunshot_effect(data.raw["ammo"][ammo_name])
    end
end
