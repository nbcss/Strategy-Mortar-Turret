local robot_control = require("script.robot_control")
local cooldown_control = require("script.cooldown_control")
local illumination_control = require("script.illumination_control")
local util = require("util")

script.on_init(function()
    robot_control.on_init()
    cooldown_control.on_init()
    illumination_control.on_init()
end)

script.on_configuration_changed(function()
    robot_control.on_init()
    cooldown_control.on_init()
    illumination_control.on_init()
end)

script.on_nth_tick(30 * 60, function(_)
    robot_control.update()
end)

script.on_event(defines.events.on_tick, function (event)
    illumination_control.on_tick(event)
    cooldown_control.on_tick(event)
end)

script.on_event(defines.events.on_script_trigger_effect, function(event)
    if event.effect_id == 'mortar-turret-robot-shoot' then
        if robot_control.register_turret(event.cause_entity) then
            script.register_on_object_destroyed(event.cause_entity)
        end
    elseif event.effect_id == 'mortar-turret-robot-deploy' then
        robot_control.register_deployed_robot(event.cause_entity)
        script.register_on_object_destroyed(event.cause_entity)
    elseif event.effect_id == 'mortar-turret-illumination-damage' then
        illumination_control.apply(event.cause_entity, event.target_entity)
    elseif util.string_starts_with(event.effect_id, 'mortar-turret-cooldown-') then
        if not event.cause_entity or event.cause_entity.name ~= "mortar-turret" then return end
        local cooldown = tonumber(string.sub(event.effect_id, 1 + #'mortar-turret-cooldown-'))
        cooldown_control.apply(cooldown * 60, event.cause_entity)
    end
end)

script.on_event(defines.events.on_object_destroyed, function(event)
    if event.type == defines.target_type.entity and event.useful_id then
        robot_control.on_object_destroyed(event.useful_id)
    end
end)

script.on_event(defines.events.on_entity_cloned, function(event)
    cooldown_control.on_entity_cloned(event)
end,
{
    {filter = "name", name = "mortar-turret"}
})
