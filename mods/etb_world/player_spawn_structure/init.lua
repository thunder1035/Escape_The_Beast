-- Load the schematic file
local spawn_structure = minetest.get_modpath("player_spawn_structure") .. "/schematics/ETB_world.mts"

-- Register an on-join function to spawn the structure if it's the player's first join
core.register_on_newplayer(function(player)
    -- Define the spawn position
    local spawn_pos = {x = 0, y = 0, z = 0} -- Adjust y to be high enough to avoid underground spawns

    -- Place the structure at the spawn position
    minetest.place_schematic(spawn_pos, spawn_structure, "0", {}, true)

    -- Set the player's spawn position to be within the structure
    player:set_pos({x = spawn_pos.x + 80 , y = spawn_pos.y + 32, z = spawn_pos.z + 200}) -- Adjust if needed

end)

