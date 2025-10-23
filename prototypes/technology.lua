data:extend {
    {
        type = "technology",
        name = "mortar-turret",
        icon_size = 256,
        icon_mipmaps = 4,
        icon = "__strategy-mortar-turret__/graphics/icons/mortar-turret.png",
        effects = {
            { type = "unlock-recipe", recipe = "mortar-turret" },
        },
        prerequisites = { "gun-turret", "military-2" },
        unit = {
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 }
            },
            time = 30
        },
        order = "e-c-c"
    }
}
