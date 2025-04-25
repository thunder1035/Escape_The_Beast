
-- Spawn entity when a player joins the game
minetest.register_on_joinplayer(function(player)
    local target_pos = {x = 21, y = 31, z = 200} -- Specific position for the entity

    -- Check if the entity already exists at the target position
    local objects = minetest.get_objects_inside_radius(target_pos, 1)
    local entity_exists = false
    for _, obj in ipairs(objects) do
        if obj:get_luaentity() and obj:get_luaentity().name == "cyber_car:cyber_car" then
            entity_exists = true
            break
        end
    end

    -- Spawn the entity only if it doesn't already exist
    if not entity_exists then
        minetest.add_entity(target_pos, "cyber_car:cyber_car")
    end
end)
