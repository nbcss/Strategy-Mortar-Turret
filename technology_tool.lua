local technology_tool = {}

function technology_tool.remove_effect(technology, remove_condition)
    if data.raw.technology[technology] and data.raw.technology[technology].effects then
        for index, effect in ipairs(data.raw.technology[technology].effects) do
            if remove_condition(effect) then
                table.remove(data.raw.technology[technology].effects, index)
                break
            end
        end
    end
end

function technology_tool.add_effect(technology, effect)
    if data.raw.technology[technology] then
        if not data.raw.technology[technology].effects then
            data.raw.technology[technology].effects = {}
        end
        table.insert(data.raw.technology[technology].effects, effect)
    end
end

function technology_tool.has_unlock_recipe(technology, recipe)
    if data.raw.technology[technology] and data.raw.technology[technology].effects then
        for _, effect in ipairs(data.raw.technology[technology].effects) do
            if effect.type == "unlock-recipe" and effect.recipe == recipe then
                return true
            end
        end
    end
    return false
end

function technology_tool.add_unlock_recipe(technology, recipe)
    technology_tool.add_effect(technology, { type = "unlock-recipe", recipe = recipe })
end

function technology_tool.remove_unlock_recipe(technology, recipe)
    technology_tool.remove_effect(technology, function(effect)
        return effect.type == "unlock-recipe" and effect.recipe == recipe
    end)
end

function technology_tool.add_prerequisite(technology, prerequisite_to_add)
    if data.raw.technology[technology] and data.raw.technology[technology].prerequisites then
        for index, prerequisite in ipairs(data.raw.technology[technology].prerequisites) do
            if prerequisite == prerequisite_to_add then
                table.remove(data.raw.technology[technology].prerequisites, index)
                break
            end
        end
        table.insert(data.raw.technology[technology].prerequisites, prerequisite_to_add)
    end
end

function technology_tool.remove_prerequisite(technology, prerequisite_to_remove)
    if data.raw.technology[technology] and data.raw.technology[technology].prerequisites then
        for index, prerequisite in ipairs(data.raw.technology[technology].prerequisites) do
            if prerequisite == prerequisite_to_remove then
                table.remove(data.raw.technology[technology].prerequisites, index)
                break
            end
        end
    end
end

return technology_tool
