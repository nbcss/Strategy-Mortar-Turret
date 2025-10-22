local technology_control = {}

function technology_control.remove_effect(technology, remove_condition)
    if data.raw.technology[technology] then
        for index, effect in ipairs(data.raw.technology[technology].effects) do
            if remove_condition(effect) then
                table.remove(data.raw.technology[technology].effects, index)
                break
            end
        end
    end
end

function technology_control.add_effect(technology, effect)
    if data.raw.technology[technology] then
		table.insert(data.raw.technology[technology].effects, effect)
	end
end

function technology_control.add_unlock_recipe(technology, recipe)
    technology_control.add_effect(technology, {type = "unlock-recipe", recipe = recipe})
end

return technology_control
