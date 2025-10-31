local common = {}

local mortar_stream_template = table.deepcopy(data.raw["stream"]["mortar-bomb-projectile-stream"])
mortar_stream_template.target_position_deviation = 2.0
mortar_stream_template.action = {}
mortar_stream_template.particle = {}

function common.create_mortar_stream(projectile_stream_prototype)
    return util.merge { mortar_stream_template, projectile_stream_prototype }
end

function common.robot_deploy_effect()
    return {
        type = "direct",
        action_delivery = {
            type = "instant",
            target_effects = {
                type = "script",
                effect_id = "mortar-turret-robot-deploy"
            }
        }
    }
end

return common