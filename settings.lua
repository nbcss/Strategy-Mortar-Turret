local constants = require("constants")

data:extend{
    {
        type = "bool-setting",
        name = constants.name_prefix.."directional-turret-range",
        order = "a",
        setting_type = "startup",
        default_value = true,
    },
    {
        type = "bool-setting",
        name = constants.name_prefix.."remove-aai-ironclad",
        order = "b",
        setting_type = "startup",
        default_value = false,
    },
}

for _, ammo_name in ipairs(constants.ammo_types) do
    data:extend{{
        type = "bool-setting",
        name = constants.name_prefix.."enable-ammo-"..ammo_name,
        order = "c-a",
        setting_type = "startup",
        default_value = true,
    }}
end
