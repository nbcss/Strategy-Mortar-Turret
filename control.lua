local robot_control = require("script.robot_control")
local cooldown_control = require("script.cooldown_control")
local hypnosis_control = require("script.hypnosis_control")
local illumination_control = require("script.illumination_control")
local bonus_damage_control = require("script.bonus_damage_control")
local constants = require("constants")
local util = require("util")

local function update_bonus(force)
    local hypnosis_bonus = 0
    if settings.startup[constants.name_prefix .. "enable-ammo-mortar-hypnosis-ammo"].value == true then
        hypnosis_bonus = force.get_ammo_damage_modifier("mortar-hypnosis-effect")
    end
    if hypnosis_bonus > 0 then
        remote.call("custom-bonus-gui", "set", force, {
            name = constants.name_prefix .. "hypnosis-bonus",
            mod_name = constants.mod_name,
            order = "sma-hypnosis",
            icons = {
                { type = 'item', name = 'mortar-hypnosis-ammo' },
            },
            texts = {
                { "", { "strategy-mortar-turret.hypnosis-chance" }, ": ×", string.format("%.1f", 1 + hypnosis_bonus) },
            }
        })
    else
        remote.call("custom-bonus-gui", "remove", force, constants.name_prefix .. "hypnosis-bonus")
    end

    local illumination_bonus = 0
    if settings.startup[constants.name_prefix .. "enable-ammo-mortar-illumination-ammo"].value == true then
        illumination_bonus = force.get_ammo_damage_modifier("mortar-illumination-effect")
    end
    if illumination_bonus > 0 then
        remote.call("custom-bonus-gui", "set", force, {
            name = constants.name_prefix .. "illumination-bonus",
            mod_name = constants.mod_name,
            order = "sma-illumination",
            icons = {
                { type = 'item', name = 'mortar-illumination-ammo' },
            },
            texts = {
                { "", { "strategy-mortar-turret.illumination-damage-bonus" }, ": +", { "format-percent", illumination_bonus * 100 } },
            }
        })
    else
        remote.call("custom-bonus-gui", "remove", force, constants.name_prefix .. "illumination-bonus")
    end
end

script.on_init(function()
    robot_control.on_init()
    cooldown_control.on_init()
    bonus_damage_control.on_init()
end)

script.on_configuration_changed(function()
    robot_control.on_init()
    cooldown_control.on_init()
    bonus_damage_control.on_init()
    for _, force in pairs(game.forces) do
        update_bonus(force)
    end
end)

script.on_nth_tick(30 * 60, function(_)
    robot_control.update()
end)

script.on_event(defines.events.on_tick, function(event)
    bonus_damage_control.on_tick(event)
    cooldown_control.on_tick(event)
end)

-- replace turret with tilted version to ensure correct hitbox
local replace_tilted_turret = function(event)
    if event.entity.direction == defines.direction.north or event.entity.direction == defines.direction.east or
        event.entity.direction == defines.direction.south or event.entity.direction == defines.direction.west then
        return
    end
    if event.entity.name == "mortar-turret" then
        local tilted_turret = event.entity.surface.create_entity {
            name = "tilted-mortar-turret",
            position = event.entity.position,
            direction = event.entity.direction,
            quality = event.entity.quality,
            force = event.entity.force,
            player = event.entity.last_user,
            raise_built = false,
            create_build_effect_smoke = false,
        }
        tilted_turret.copy_settings(event.entity)
        event.entity.destroy()
    elseif event.entity.name == "heavy-mortar-turret" then
        local tilted_turret = event.entity.surface.create_entity {
            name = "tilted-heavy-mortar-turret",
            position = event.entity.position,
            direction = event.entity.direction,
            quality = event.entity.quality,
            force = event.entity.force,
            player = event.entity.last_user,
            raise_built = false,
            create_build_effect_smoke = false,
        }
        tilted_turret.copy_settings(event.entity)
        event.entity.destroy()
    end
end

script.on_event(defines.events.on_built_entity, replace_tilted_turret,
    { { filter = "name", name = "mortar-turret" }, { filter = "name", name = "heavy-mortar-turret" } })
script.on_event(defines.events.on_robot_built_entity, replace_tilted_turret,
    { { filter = "name", name = "mortar-turret" }, { filter = "name", name = "heavy-mortar-turret" } })
script.on_event(defines.events.script_raised_built, replace_tilted_turret,
    { { filter = "name", name = "mortar-turret" }, { filter = "name", name = "heavy-mortar-turret" } })
script.on_event(defines.events.on_space_platform_built_entity, replace_tilted_turret,
    { { filter = "name", name = "mortar-turret" }, { filter = "name", name = "heavy-mortar-turret" } })

script.on_event(defines.events.on_research_finished, function (event) update_bonus(event.research.force) end)
script.on_event(defines.events.on_research_reversed, function (event) update_bonus(event.research.force) end)
script.on_event(defines.events.on_force_reset, function (event) update_bonus(event.force) end)

script.on_event(defines.events.on_script_trigger_effect, function(event)
    if event.effect_id == 'mortar-turret-robot-shoot' then
        if robot_control.register_turret(event.cause_entity) then
            script.register_on_object_destroyed(event.cause_entity)
        end
    elseif event.effect_id == 'mortar-turret-robot-deploy' then
        robot_control.register_deployed_robot(event.cause_entity)
        script.register_on_object_destroyed(event.cause_entity)
    elseif event.effect_id == 'mortar-apply-hypnosis' then
        hypnosis_control.apply_effect(event.cause_entity, event.source_entity, event.target_entity)
    elseif event.effect_id == 'mortar-kill-unit' then
        if event.target_entity and event.target_entity.valid then
            event.target_entity.die()
        end
    elseif event.effect_id == 'mortar-turret-illumination-damage' then
        illumination_control.update_entity_damage(event.cause_entity, event.source_entity, event.target_entity)
    end
    -- elseif event.effect_id == 'mortar-bouncing' then
    --     if event.source_position and event.target_position and event.cause_entity then
    --         local next_target = {
    --             x = event.target_position.x + (event.target_position.x - event.source_position.x) * 0.75,
    --             y = event.target_position.y + (event.target_position.y - event.source_position.y) * 0.75,
    --         }
    --         local surface = game.surfaces[event.surface_index]
    --         -- game.print(event.target_entity.name)
    --         surface.create_entity{
    --             name="mortar-bouncing-projectile-stream",
    --             position=event.cause_entity.position,
    --             direction = event.cause_entity.direction,
    --             quality = event.cause_entity.quality,
    --             force = event.cause_entity.force,
    --             source = event.target_position,
    --             target = next_target,
    --             cause = event.cause_entity,
    --         }
    --     end
    -- elseif util.string_starts_with(event.effect_id, 'mortar-turret-cooldown-') then
    --     if not event.cause_entity or event.cause_entity.type ~= "ammo-turret" then return end
    --     local cooldown = tonumber(string.sub(event.effect_id, 1 + #'mortar-turret-cooldown-'))
    --     cooldown_control.apply(cooldown * 60, event.cause_entity)
    -- end
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
        { filter = "name", name = "mortar-turret" },
        { filter = "name", name = "heavy-mortar-turret" },
    })
