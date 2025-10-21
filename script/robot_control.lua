local robot_control = {}

function robot_control.on_init()
    storage.turrets = {}
    storage.robot_index = {}
end

function robot_control.register_turret(turret)
    storage.turrets[turret.unit_number] = {
        robot_deploy_locator = nil,
        deployed_robots = {}
    }
end

function robot_control.register_deployed_robot(robot)
    local turret = robot.combat_robot_owner
    if turret and turret.name == "mortar-turret" and storage.turrets[turret.unit_number] then
        -- indexing robot turret id
        storage.robot_index[robot.unit_number] = turret.unit_number
        if robot.name == "mortar-turret-robot-locator" then
            -- relocate current deployed robots
            for _, deployed_robot in pairs(storage.turrets[turret.unit_number].deployed_robots) do
                if deployed_robot.valid then
                    -- mark for delete elsewise?
                    game.print(deployed_robot)
                    deployed_robot.combat_robot_owner = robot
                end
            end
            -- remove previous locator
            if storage.turrets[turret.unit_number].robot_deploy_locator and storage.turrets[turret.unit_number].robot_deploy_locator.valid then
                storage.turrets[turret.unit_number].robot_deploy_locator.destroy()
            end
            storage.turrets[turret.unit_number].robot_deploy_locator = robot
        else
            -- apply random movement, may need a better algorithm
            robot.set_movement({math.random(-1, 1), math.random(-1, 1)}, 0.03)
            -- redirect to current locator
            storage.turrets[turret.unit_number].deployed_robots[robot.unit_number] = robot
            if storage.turrets[turret.unit_number].robot_deploy_locator then
                robot.combat_robot_owner = storage.turrets[turret.unit_number].robot_deploy_locator
            end
        end
    end
end

-- remove turret from storage, assume it exists
local function remove_turret(turret_unit_number)
    storage.turrets[turret_unit_number] = nil
end

-- remove robot from storage, assume it exists
local function remove_deployed_robot(robot_unit_number)
    local turret = storage.turrets[storage.robot_index[robot_unit_number]]
    if turret then
        if turret.robot_deploy_locator and turret.robot_deploy_locator.unit_number == robot_unit_number then
            turret.robot_deploy_locator = nil
        else
            turret.deployed_robots[robot_unit_number] = nil
        end
    end
    storage.robot_index[robot_unit_number] = nil
end

function robot_control.on_object_destroyed(unit_number)
    if storage.turrets[unit_number] then
        remove_turret(unit_number)
    elseif storage.robot_index[unit_number] then
        remove_deployed_robot(unit_number)
    end
end

return robot_control