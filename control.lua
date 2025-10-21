local robot_control = require("script.robot_control")
script.on_init(
    function()
        robot_control.on_init()
    end
)

script.on_event(defines.events.on_script_trigger_effect, function(event)
    if event.effect_id == 'mortar-turret-place' then
        robot_control.register_turret(event.cause_entity)
        script.register_on_object_destroyed(event.cause_entity)
    elseif event.effect_id == 'mortar-turret-robot-deploy' then
        robot_control.register_deployed_robot(event.cause_entity)
        script.register_on_object_destroyed(event.cause_entity)
    end
end)

script.on_event(defines.events.on_object_destroyed, function(event)
    if event.type == defines.target_type.entity and event.useful_id then
        robot_control.on_object_destroyed(event.useful_id)
    end
end)
