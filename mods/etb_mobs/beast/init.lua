-- 1. Show Fullscreen Win Formspec
local function show_fullscreen_formspec(player_name)
    local formspec = [[
        formspec_version[4]
        size[16,9]
        label[1,1;Congratulations! You defeated the Beast!]
        image[4.5,2;9,4.5;image_won.png]
        button[6.5,6;3,1;exit_game;Exit Game]
    ]]
    minetest.show_formspec(player_name, "beast:end_game", formspec)
end

-- 2. Handle Button Clicks
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "beast:end_game" and fields.exit_game then
        local name = player:get_player_name()
        minetest.kick_player(name, "YOU WON!".."\n"..
		"Thanks for playing")
    end
end)

--beast--
mobs:register_mob("beast:beast", {
type = "monster",
	hp_min = 500,
	hp_max = 500,
	stepheight = 1,
	pathfinding = true,
	visual_size = {x=1.5, y= 1.5},
	collisionbox =  {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "beast_2.b3d",
	textures = {"beast.png",},
	glow = 1,
	view_range = 10000,
	walk_velocity = 5,
	run_velocity = 6,
	damage = 3,
	drops = {},
	armor = 250,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	jump = true,
	jump_height = 3,
	suffocation = 0,
	reach = 1,
	fear_height = 0,
	walk_chance = 100,
	stand_chance = 50,
	attack_chance = 50,
	blood_amount = 0,
	randomly_turn = true,
	passive = false,
	group_attack = false,
	attack_players = true,
	attack_type = "dogfight",
	on_punch = function(self, hitter)
    if hitter:is_player() then
        self._last_hit_by_player = hitter:get_player_name()
        self._last_hit_time = minetest.get_gametime()
    end
end,
	sounds = {
        	random = {
            "beast_sound_01",
            "beast_sound_02",
            "beast_sound_03",
            "beast_sound_04"
        },  -- List of sounds for random selection
        damage = "beast_sound_05",  -- Sound when it takes damage
    },
    
on_die = function(self, hitter)
    local pos = self.object:get_pos()
    local players_nearby = false
    local radius = 50

    -- Check if any player is near the beast
    local objs = minetest.get_objects_inside_radius(pos, radius)
    for _, obj in ipairs(objs) do
        if obj:is_player() then
            players_nearby = true
            break
        end
    end

    -- Update spawner metadata
    local spawners = minetest.find_nodes_in_area(vector.subtract(pos, 50), vector.add(pos, 50), {"beast:spawner_node"})
    for _, spawner_pos in ipairs(spawners) do
        local meta = minetest.get_meta(spawner_pos)
        if players_nearby then
    meta:set_int("has_spawned", 1)
    
    -- Loop and show victory screen to all nearby players
    for _, obj in ipairs(objs) do
        if obj:is_player() then
            show_fullscreen_formspec(obj:get_player_name())
        end
    end
else
    meta:set_int("has_spawned", 0)
end
    end


end,
do_custom = function(self)
    local timer = self.ray_timer or 0
    timer = timer + 1

    if timer >= 90 then  -- Fire every 90 ticks (~4.5 seconds)
        local pos = self.object:get_pos()
        local target = self.attack

        if target and target:is_player() then
            local t_pos = target:get_pos()
            local distance = vector.distance(pos, t_pos)

            if distance < 5 then
                local start_pos = vector.add(pos, {x=0, y=1, z=0}) -- beam from slightly above mob
                local dir = vector.normalize(vector.subtract(t_pos, start_pos))

                -- Draw beam using particle trail
                for i = 1, math.floor(distance * 4) do
                    local beam_step = vector.add(start_pos, vector.multiply(dir, i * 0.25))
                    minetest.add_particle({
                        pos = beam_step,
                        velocity = {x=0, y=0, z=0},
                        acceleration = {x=0, y=0, z=0},
                        expirationtime = 0.2,
                        size = 2,
                        texture = "blast.png",
                        glow = 8,
                        physical = true,
                    })
                end

                -- Deal minimal damage
                local hp = target:get_hp()
                if hp > 0 then
                    target:set_hp(hp - math.random(1, 2))  -- Random small damage
                    minetest.sound_play("beam_hit", {pos = t_pos, gain = 0.5, max_hear_distance = 20})
                end
            end
        end
        timer = 0 -- Reset timer after firing
    end

    self.ray_timer = timer
end,


	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	selectionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	animation = {
		stand_start = 0,
		stand_end = 225,
		stand_speed = 15,
		walk_start = 169,
		walk_end = 186,
		walk_speed = 15,
		run_start = 200,
		run_end = 220,
		run_speed = 20,
		punch_start = 189,
		punch_end = 200,
		punch2_start = 200,
		punch2_end = 220,
		punch_speed = 21,
		die_start = 160,
		die_end = 165,
		die_speed = 15,
	},
})

local MP = minetest.get_modpath(minetest.get_current_modname()) .. "/"
local input = io.open(MP .. "spawn.lua", "r")

if input then
	input:close()
	input = nil
	dofile(MP .. "spawn.lua")
else

	mobs:spawn({
		name = "beast:beast",
		nodes = {"misc:skull"},
		neighbors = "air",
		chance = 7000,
		active_object_count = 2,
		min_height = -31000,
		max_height = 31000,
	})

end

mobs:register_spawn("beast:beast", {"misc:skull"}, 20, -1, 14000, 1, -64)

mobs:register_egg("beast:beast", "beast", "beast.png", 3)

--[[
minetest.register_node("beast:spawner_node", {
    description = "Beast Spawner",
    tiles = { "break_me.png" },
    is_ground_content = false,
    groups = {dig_immediate = 3,crumbly = 1 },

    -- Function when the node is broken
    on_dig = function(pos, node, digger)
        -- Spawn the beast entity at the position of the node
        minetest.add_entity(pos, "beast:beast")

        -- Send a chat message to all players
        minetest.chat_send_all("The beast has been unleashed!")

        -- Remove the node after being broken
        minetest.remove_node(pos)
    end,
})
--]]--


-- Define the spawner node
minetest.register_node("beast:spawner_node", {
	description = "Beast Proximity Spawner",
	tiles = { "transparent.png" },
	drawtype = "airlike",
	collision_box = {
	type = "fixed",
	fixed = {-0, -0, -0, 0, -0, 0},
	},
	selection_box = {
	type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, -0.5000, 0.5000},
	},
	is_ground_content = false,
	groups = {},

	-- Node metadata to track spawning status
	on_construct = function(pos)
	local meta = minetest.get_meta(pos)
        meta:set_int("has_spawned", 0) -- Set default: no entity spawned yet
	end,
    
})

-- Function to check proximity and spawn the beast
--  Smart Spawner: scans, spawns, tracks beast
local function check_proximity_and_spawn(pos, radius)
    local meta = minetest.get_meta(pos)
    local has_spawned = meta:get_int("has_spawned")
    local beast_found = false
    local player_found = false

    -- Scan for objects
    local objects_nearby = minetest.get_objects_inside_radius(pos, radius)
    for _, obj in ipairs(objects_nearby) do
        if obj:is_player() then
            player_found = true
        end
        if not obj:is_player() and obj:get_luaentity() then
            local ent = obj:get_luaentity()
            if ent.name == "beast:beast" and obj:get_hp() > 0 then
                beast_found = true
            end
        end
    end

    -- 📌 Case 1: Beast is nearby, but metadata says no spawn
    if beast_found and has_spawned == 0 then
        meta:set_int("has_spawned", 1)
    end

    -- 📌 Case 2: No beast nearby, metadata says it spawned → assume it died
    if not beast_found and has_spawned == 1 then
        meta:set_int("has_spawned", 1) -- Leave as spawned, no need to spawn again
    end

    -- 📌 Case 3: Player nearby, no beast, not yet spawned → spawn it
    if player_found and not beast_found and has_spawned == 0 then
        local spawn_pos = vector.add(pos, {x=0, y=1, z=0})
        minetest.add_entity(spawn_pos, "beast:beast")
        meta:set_int("has_spawned", 1)
        minetest.chat_send_all(" The Beast has been unleashed...")
        minetest.chat_send_all(" It has sensed your presence!")
    end
end

-- 🧠 Run spawner check every second
minetest.register_abm({
    nodenames = { "beast:spawner_node" },
    interval = 1.0,
    chance = 1,
    action = function(pos)
        local radius = 25
        check_proximity_and_spawn(pos, radius)
    end,
})

---------------------------------------------------------------------------FIXME- TEMPORARY CODE
local DETECTION_RADIUS = 50
local TARGET_ENTITY_NAME = "beast:beast"
local previous_states = {}  -- per-node status tracker
local beast_was_alive = true  -- global tracker for win screen

--  Register the Beast Detector node
minetest.register_node("beast:beast_detector", {
    description = "Beast Detector",
    tiles = {"transparent.png"},
    use_texture_alpha = "blend",
    groups = {cracky = 2},
    on_construct = function(pos)
        local key = minetest.pos_to_string(pos)
        previous_states[key] = nil
    end,
    on_destruct = function(pos)
        local key = minetest.pos_to_string(pos)
        previous_states[key] = nil
    end,
})

-- 🔍 Checks if beast is alive near a given position
local function is_beast_alive_at(pos, radius)
    local objects = minetest.get_objects_inside_radius(pos, radius)
    for _, obj in ipairs(objects) do
        if not obj:is_player() and obj:get_luaentity() then
            local luaent = obj:get_luaentity()
            if luaent.name == TARGET_ENTITY_NAME and obj:get_hp() > 0 then
                return true
            end
        end
    end
    return false
end

--Show status formspec near detector node
local function show_status_formspec(pos, status)
    local formspec = "formspec_version[4]" ..
                     "size[10,3]" ..
                     "label[1,1;Beast Status Changed: " .. minetest.formspec_escape(status) .. "]" ..
                     "button_exit[3,2;4,1;exit;Close]"

    local players = minetest.get_connected_players()
    for _, player in ipairs(players) do
        if vector.distance(player:get_pos(), pos) <= DETECTION_RADIUS then
            --minetest.show_formspec(player:get_player_name(), "beast:beast_status", formspec)
        end
    end
end

-- 🧠 ABM to detect beast near node
minetest.register_abm({
    label = "Beast Detector Logic",
    nodenames = {"beast:beast_detector"},
    interval = 2.0,
    chance = 1,
    action = function(pos)
        local key = minetest.pos_to_string(pos)
        local is_alive = is_beast_alive_at(pos, DETECTION_RADIUS)
        local was_alive = previous_states[key]

        if was_alive ~= is_alive then
            local status = is_alive and "Beast is ALIVE" or "Beast is DEAD"
            previous_states[key] = is_alive
        end
    end
})

-- 🔁 Globalstep to check if beast is dead anywhere
local check_timer = 0
minetest.register_globalstep(function(dtime)
    check_timer = check_timer + dtime
    if check_timer < 1 then return end
    check_timer = 0

    local beast_alive = false
    for _, player in ipairs(minetest.get_connected_players()) do
        local objs = minetest.get_objects_inside_radius(player:get_pos(), 100)
        for _, obj in ipairs(objs) do
            if not obj:is_player() and obj:get_luaentity() then
                local ent = obj:get_luaentity()
                if ent.name == TARGET_ENTITY_NAME and obj:get_hp() > 0 then
                    beast_alive = true
                    break
                end
            end
        end
        if beast_alive then break end
    end

    if beast_was_alive and not beast_alive then
        -- Beast just died — show fullscreen win to all players
        for _, player in ipairs(minetest.get_connected_players()) do
            --show_fullscreen_formspec(player:get_player_name())
        end
    end
    beast_was_alive = beast_alive
end)

minetest.register_on_leaveplayer(function(player)
    local pos = player:get_pos()
    local beast_alive = false

    local objs = minetest.get_objects_inside_radius(pos, 100)
    for _, obj in ipairs(objs) do
        if not obj:is_player() and obj:get_luaentity() then
            local ent = obj:get_luaentity()
            if ent.name == "beast:beast" and obj:get_hp() > 0 then
                beast_alive = true
                break
            end
        end
    end

    local spawners = minetest.find_nodes_in_area(
        vector.subtract(pos, 50),
        vector.add(pos, 50),
        {"beast:spawner_node"}
    )

    for _, spawner_pos in ipairs(spawners) do
        local meta = minetest.get_meta(spawner_pos)
        if beast_alive then
            meta:set_int("has_spawned", 0) -- 🧠 Reset if beast alive
        else
            meta:set_int("has_spawned", 1) -- Keep 1 if beast dead
        end
    end
end)

--------------------------------------------------------------------
local modpath = minetest.get_modpath("beast")

-- Load files

dofile(modpath .. "/beast_dummy.lua")

