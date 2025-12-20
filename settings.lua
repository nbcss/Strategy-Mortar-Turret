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
        name = constants.name_prefix.."reduce-mortar-ammo-stack-size",
        order = "b",
        setting_type = "startup",
        default_value = true,
    },
    {
        type = "bool-setting",
        name = constants.name_prefix.."cheap-ammo-mode",
        order = "b",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "bool-setting",
        name = constants.name_prefix.."remove-aai-ironclad",
        order = "c",
        setting_type = "startup",
        default_value = false,
    },
}

for _, ammo_name in ipairs(constants.ammo_types) do
    data:extend{{
        type = "bool-setting",
        name = constants.name_prefix.."enable-ammo-"..ammo_name,
        order = "x-a",
        setting_type = "startup",
        default_value = true,
    }}
end
