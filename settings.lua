local constants = require("constants")

data:extend{
    {
        type = "bool-setting",
        name = constants.name_prefix.."directional-turret-range",
        setting_type = "startup",
        default_value = true,
    },
    {
        type = "bool-setting",
        name = constants.name_prefix.."remove-aai-ironclad",
        setting_type = "startup",
        default_value = false,
    },
}