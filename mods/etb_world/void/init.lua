local VOID_Y_THRESHOLD = 0
local VOID_RESPAWN_POS = {x = 80, y = 32, z = 200}

minetest.register_globalstep(function(dtime)
    for _, obj in ipairs(minetest.get_objects_inside_radius({x = 0, y = VOID_Y_THRESHOLD, z = 0}, 10000)) do
        if obj then
            local pos = obj:get_pos()
            if pos and pos.y <= VOID_Y_THRESHOLD then
                if obj:is_player() then
                    obj:set_pos(VOID_RESPAWN_POS)
                    minetest.chat_send_player(obj:get_player_name(), "You fell into the void! Teleporting you to safety...")
                end
            end
        end
    end
end)

