local constants = require("constants")

data:extend{
    {
        type = "bool-setting",
        name = constants.name_prefix.."enable-8-direction-mortar-turret",
        setting_type = "startup",
        default_value = false,
    },
    {
        type = "bool-setting",
        name = constants.name_prefix.."remove-aai-ironclad",
        setting_type = "startup",
        default_value = false,
    },
}