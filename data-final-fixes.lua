local constants = require("constants")

for _, tech in pairs(data.raw.technology) do
    if tech.effects then
        for _, effect in pairs(tech.effects) do
            if effect.type == "gun-speed" and effect.ammo_category == "bullet" then
                table.insert(tech.effects, util.merge{effect, {ammo_category = constants.mortar_strategy_ammo_category}})
            end
        end
    end
end