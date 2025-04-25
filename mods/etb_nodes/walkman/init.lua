local music_tracks = {
    {"Fairy Dance", "track_1"},
    {"Unfinished Business", "track_2"},
    {"tchaikovsky", "track_3"},
    {"Shrine to the Smoldering Volcano", "track_4"}
}

local playing_players = {} -- name => {handle, track}

-- Helper to build formspec
local function get_walkman_formspec(current_track)
    local fs = "formspec_version[4]size[10,8]label[3.5,0.5;Walkman Music List]"

    for i, track in ipairs(music_tracks) do
        fs = fs .. string.format("button[3,%f;4,1;play_%d;%s]", 1 + (i - 1) * 1.2, i, track[1])
    end

    fs = fs ..
        "button[2,5.8;2,1;play_resume; > Play]" ..
        "button[6,5.8;2,1;pause; || Pause]" ..
        "button_exit[3.5,7;3,1;exit;Close]"

    return fs
end

-- Show headphone overlay
local function add_headphones(player)
    player:set_properties({
        textures = {"character.png^walkman_headphones.png"}
    })
end

-- Remove headphone overlay
local function remove_headphones(player)
    player:set_properties({
        textures = {"character.png"}
    })
end

-- Play music and track it
local function play_music(player, track_name)
    local name = player:get_player_name()

    -- Stop previous sound if any
    if playing_players[name] and playing_players[name].handle then
        minetest.sound_stop(playing_players[name].handle)
    end

    -- Play new track
    local handle = minetest.sound_play(track_name, {
        to_player = name,
        gain = 1.0
    })

    playing_players[name] = {
        handle = handle,
        track = track_name
    }

    add_headphones(player)

    -- Optional: Remove headphones after 60s if still same sound
    minetest.after(60, function()
        local p = minetest.get_player_by_name(name)
        if p and playing_players[name] and playing_players[name].handle == handle then
            remove_headphones(p)
            playing_players[name] = nil
        end
    end)
end

-- Pause music
local function pause_music(player)
    local name = player:get_player_name()
    local data = playing_players[name]

    if data and data.handle then
        minetest.sound_stop(data.handle)
        data.handle = nil
        remove_headphones(player)
    end
end

-- Resume music if paused
local function resume_music(player)
    local name = player:get_player_name()
    local data = playing_players[name]
    if data and not data.handle and data.track then
        play_music(player, data.track)
    end
end

-- Handle player form input
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "walkman:music_menu" then return end

    for i, track in ipairs(music_tracks) do
        if fields["play_" .. i] then
            play_music(player, track[2])
            return
        end
    end

    if fields.play_resume then
        resume_music(player)
    elseif fields.pause then
        pause_music(player)
    end
end)

-- Walkman Node
minetest.register_node("walkman:walkman", {
    description = "Walkman\nWalkman of Major K_11",
    drawtype = "mesh",
    inventory_image = "walkman_inv.png",
    wield_image = "walkman_inv.png",
    mesh = "walkman.obj",
    tiles = {"walkman.jpg"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3, crumbly = 3},
    drop = "walkman:walkman",
    light_source = 2,
    collision_box = {
        type = "fixed",
        fixed = {0, 0, 0, 0, 0, 0},
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
    },

    -- Open formspec on use
    on_use = function(itemstack, user, pointed_thing)
        if user:is_player() then
            minetest.show_formspec(
                user:get_player_name(),
                "walkman:music_menu",
                get_walkman_formspec()
            )
        end
        return itemstack
    end,
})

