local robot_deploy_effect = {
    {
        type = "direct",
        action_delivery = {
            {
                type = "instant",
                target_effects = {
                    {
                        type = "script",
                        effect_id = "mortar-turret-robot-deploy"
                    }
                }
            }
        }
    }
}

local robot_locator = table.deepcopy(data.raw["combat-robot"]["distractor"])
robot_locator.name = "mortar-turret-robot-locator"
robot_locator.attack_parameters.warmup = 999999999
robot_locator.follows_player = false
robot_locator.hidden = true
robot_locator.speed = 0
robot_locator.max_speed = 0
robot_locator.time_to_live = 60 * 60 * 3
robot_locator.is_military_target = false
robot_locator.collision_box = {{0, 0}, {0, 0}}
robot_locator.created_effect = robot_deploy_effect

local defender_robot = table.deepcopy(data.raw["combat-robot"]["defender"])
defender_robot.name = "deployed-defender-robot"
defender_robot.speed = 0.03
defender_robot.max_speed = 0.05 -- reduce speed for more stable movement
defender_robot.hidden_in_factoriopedia = true
defender_robot.localised_name = {"entity-name.defender"}
defender_robot.created_effect = robot_deploy_effect

data:extend({robot_locator, defender_robot})