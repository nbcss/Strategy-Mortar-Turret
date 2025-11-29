local constants = require("constants")

-- mortar turret
require("prototypes.mortar_turret")
require("prototypes.heavy_mortar_turret")
-- tech & ammo
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
    -- AAI base mortar bombs update
    data.raw["recipe"]["mortar-bomb"].additional_categories = { "ammunition" }
    data.raw["recipe"]["mortar-cluster-bomb"].additional_categories = { "ammunition" }
    -- strategy ammos update
    for _, ammo_name in ipairs(constants.ammo_types) do
        if data.raw["recipe"][ammo_name] then
            data.raw["recipe"][ammo_name].additional_categories = { "ammunition" }
        end
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
