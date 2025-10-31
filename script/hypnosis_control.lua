local hypnosis_control = {}

function hypnosis_control.apply_effect(cause_entity, source_entity, target_entity)
    if not target_entity or not target_entity.valid or target_entity.type ~= "unit" then return end
    local chance = 5 / target_entity.max_health
    if math.random() < chance then
        local force = "player"
        if cause_entity and cause_entity.valid then
            force = cause_entity.force.name
        elseif source_entity and source_entity.valid then
            force = source_entity.force.name
        end
        target_entity.force = force
        target_entity.surface.create_entity{name="hypnosis-sticker", position=target_entity.position, target=target_entity}
        if target_entity.commandable then
            target_entity.commandable.set_command{
                type = defines.command.wander,
            }
        end
    end
end

return hypnosis_control
