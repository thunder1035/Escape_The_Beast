-- Maximum number of lives a player can have
local MAX_LIVES = 3

-- Location to teleport the player when lives are over
local GAME_OVER_LOCATION = {x = 10, y = 10, z = 10}

-- Table to store custom respawn positions for players
local respawn_positions = {}

-- Function to get player lives from metadata
local function get_player_lives(player)
    local meta = player:get_meta()
    local lives = meta:get_int("lives")
    if lives == 0 then
        -- If lives are not set, initialize to MAX_LIVES
        lives = MAX_LIVES
        meta:set_int("lives", lives)
    end
    return lives
end

-- Function to set player lives in metadata
local function set_player_lives(player, lives)
    local meta = player:get_meta()
    meta:set_int("lives", lives)
end

-- Show permanent "Game Over" formspec
local function show_game_over_form(player)
    local player_name = player:get_player_name()

    -- Teleport the player to the designated "Game Over" location
    player:set_pos(GAME_OVER_LOCATION)

    -- Update the custom respawn position for the player
    respawn_positions[player_name] = GAME_OVER_LOCATION

    -- Display an inescapable formspec
    minetest.show_formspec(player_name, "game_over:form",
        "size[8,5]" ..
        "image[2,0;4,4;game_over_image.png]" ..
        "label[0.5,4.2;You have lost all your lives!]" ..
        "label[0.5,4.5;Restart Game with new world]" ..
        "button_exit[3,4.7;2,0.8;exit;Exit Game]"
    )

    -- Prevent player from interacting further
    player:set_hp(0)
    player:set_physics_override({speed = 0, jump = 0, gravity = 0})

    -- Redisplay the formspec if the player tries to escape
    minetest.after(0.1, function()
        if minetest.get_player_by_name(player_name) then
            minetest.show_formspec(player_name, "game_over:form",
        "size[8,5]" ..
        "image[2,0;4,4;game_over_image.png]" ..
        "label[0.5,4.2;You have lost all your lives!]" ..
        "label[0.5,4.5;Restart Game with new world]" ..
        "button_exit[3,4.7;2,0.8;exit;Exit Game]"
    )
        end
    end)
end

-- Register callback for when a player dies
minetest.register_on_dieplayer(function(player)
    local player_name = player:get_player_name()

    -- Get current lives
    local lives = get_player_lives(player)

    -- Reduce player's lives
    lives = lives - 1
    set_player_lives(player, lives)

    -- Check if the player has lives remaining
    if lives <= 0 then
        -- Teleport player to the designated location and show the game-over screen
        show_game_over_form(player)

        -- Send a chat message to inform the player
        minetest.chat_send_player(player_name, "Game Over: You have no lives remaining.")
    else
        -- Respawn the player and notify them of remaining lives
        player:set_hp(20) -- Respawn with full health
        minetest.chat_send_player(player_name, "You have " .. lives .. " lives remaining.")
    end
end)

-- Handle player respawn by teleporting to the custom respawn position if set
minetest.register_on_respawnplayer(function(player)
    local player_name = player:get_player_name()
    if respawn_positions[player_name] then
        player:set_pos(respawn_positions[player_name])
        return true -- Custom respawn handled
    end
    return false -- Use default respawn position
end)

-- Prevent any formspec escape by forcing the game-over form to reappear
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "game_over:form" then
        if fields.quit then
            -- Force player to exit the game
            local player_name = player:get_player_name()
            minetest.kick_player(player_name, "Game Over: Restart the game by creating a new world.")
        end
    end
end)

-- Register callback for joining players
minetest.register_on_joinplayer(function(player)
    local player_name = player:get_player_name()

    -- Get current lives
    local lives = get_player_lives(player)

    -- If the player has lost and the world isn't reset, keep them blocked and teleport them to the Game Over location
    if lives <= 0 then
        player:set_pos(GAME_OVER_LOCATION)
        respawn_positions[player_name] = GAME_OVER_LOCATION
        show_game_over_form(player)
        minetest.chat_send_player(player_name, "Game Over:  Restart the game with a new world.")
    else
        -- Notify the player of their remaining lives
        minetest.chat_send_player(player_name, "Welcome back! You have " .. lives .. " lives remaining.")
    end
end)

