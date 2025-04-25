-- Define the four levels and their areas/goals
local level_zones = {
    {
        pos1 = {x = 75, y = 32, z = 195},
        pos2 = {x = 85, y = 30, z = 200},
        level = 1,
        goal = "Find Area 1",
    },
    {
        pos1 = {x = 50, y = 32, z = 150},
        pos2 = {x = 70, y = 30, z = 110},
        level = 2,
        goal = "Find Area 2",
    },
    {
        pos1 = {x = 35, y = 32, z = 40},
        pos2 = {x = 15, y = 30, z = 15},
        level = 3,
        goal = "Enter Arena and kill The Beast",
    },
}

-- Function to check if a position is inside an area
local function is_in_area(pos, area)
    return pos.x >= math.min(area.pos1.x, area.pos2.x)
       and pos.x <= math.max(area.pos1.x, area.pos2.x)
       and pos.y >= math.min(area.pos1.y, area.pos2.y)
       and pos.y <= math.max(area.pos1.y, area.pos2.y)
       and pos.z >= math.min(area.pos1.z, area.pos2.z)
       and pos.z <= math.max(area.pos1.z, area.pos2.z)
end

-- Temporary HUD ID storage
local player_huds = {}

-- Function to display HUD
local function show_level_hud(player, level)
    local player_name = player:get_player_name()

    -- Remove any existing HUD for this player
    if player_huds[player_name] then
        player:hud_remove(player_huds[player_name])
        player_huds[player_name] = nil
    end

    -- Add a new HUD
    local hud_id = player:hud_add({
        hud_elem_type = "image",
        position = {x = 0.5, y = 0.1},
        offset = {x = 0, y = 0},
        text = "level_" .. level .. ".png", -- Replace with your custom image for each level
        scale = {x = 2, y = 2},
        alignment = {x = 0, y = 0},
    })

    player_huds[player_name] = hud_id

    -- Remove the HUD after a few seconds
    minetest.after(5, function()
        if player_huds[player_name] then
            player:hud_remove(player_huds[player_name])
            player_huds[player_name] = nil
        end
    end)
end

-- Check player position and assign levels
minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local player_name = player:get_player_name()
        local player_pos = player:get_pos()
        local meta = player:get_meta()

        for _, zone in ipairs(level_zones) do
            if is_in_area(player_pos, zone) then
                local current_level = meta:get_int("level")  -- Get saved level
                if current_level ~= zone.level then
                    -- Update level
                    meta:set_int("level", zone.level)
                    meta:set_string("goal", zone.goal)

                    -- Notify the player and show HUD
                    minetest.chat_send_player(player_name, "You reached level " .. zone.level .. "!")
                    minetest.chat_send_player(player_name, "Your goal: " .. zone.goal)
                    show_level_hud(player, zone.level)
                end
                break
            end
        end
    end
end)

-- Inform player of their level and goal upon joining
minetest.register_on_joinplayer(function(player)
    local player_name = player:get_player_name()
    local meta = player:get_meta()

    -- Get player's current level and goal
    local current_level = meta:get_int("level")
    local current_goal = meta:get_string("goal")

    -- Inform the player
    if current_level > 0 then
        minetest.chat_send_player(player_name, "Welcome back! You are at level " .. current_level .. ".")
        minetest.chat_send_player(player_name, "Your goal: " .. current_goal)
    else
        minetest.chat_send_player(player_name, "Welcome! Start exploring to reach level 1!")
    end
end)

-- Register an item to display player's level and goal
minetest.register_craftitem("player_levels:level_display", {
    description = "Level Display",
    inventory_image = "level_display.png", -- Replace with your custom icon
    on_use = function(itemstack, player, pointed_thing)
        local meta = player:get_meta()
        local current_level = meta:get_int("level")
        local current_goal = meta:get_string("goal")

        if current_level > 0 then
            minetest.show_formspec(
                player:get_player_name(),
                "player_levels:level_display",
                "size[6,3]" ..
                "label[0.5,0.5;You are at Level: " .. current_level .. "]" ..
                "label[0.5,1.5;Goal: " .. current_goal .. "]"
            )
        else
            minetest.chat_send_player(player:get_player_name(), "You haven't reached any level yet!")
        end
    end,
})

------------------------
-- Function to play a specific sound when reaching a particular level
local function play_level_up_sound(player, level)
    local player_name = player:get_player_name()

    -- Play different sounds based on the level reached
    if level == 1 then
        minetest.sound_play("level_1", {
            to_player = player_name,
            gain = 1.0, -- Adjust volume (1.0 is the default)
        })
    elseif level == 2 then
        minetest.sound_play("level_2", {
            to_player = player_name,
            gain = 1.0,
        })
    elseif level == 3 then
        minetest.sound_play("level_3", {
            to_player = player_name,
            gain = 1.0,
        })
    else
        -- Default sound if no specific level is reached
        minetest.sound_play("level_up", {
            to_player = player_name,
            gain = 1.0,
        })
    end
end

-- Check player position and assign levels
minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local player_name = player:get_player_name()
        local player_pos = player:get_pos()
        local meta = player:get_meta()

        for _, zone in ipairs(level_zones) do
            if is_in_area(player_pos, zone) then
                local current_level = meta:get_int("level")  -- Get saved level
                if current_level ~= zone.level then
                    -- Update level
                    meta:set_int("level", zone.level)
                    meta:set_string("goal", zone.goal)

                    -- Notify the player and show HUD
                    minetest.chat_send_player(player_name, "You reached level " .. zone.level .. "!")
                    minetest.chat_send_player(player_name, "Your goal: " .. zone.goal)
                    show_level_hud(player, zone.level)

                    -- Play sound for the specific level
                    play_level_up_sound(player, zone.level)
                end
                break
            end
        end
    end
end)
