
-------------------------------------------------------------------

minetest.register_node("tools:e_sword", {
	description = "Energy Sword".."\n"..
	"",
	drawtype = 'mesh',
	mesh = 'sword.obj',
	tiles = {"e_sword.png"},
	wield_scale = {x = 2, y = 2, z = 2},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3,crumbly = 3,},
	drop = "tools:e_sword",
	light_source =  8,
	tool_capabilities = {
	damage_groups = {fleshy= 5},
	},
	})


-------------------------------------------------------------------

minetest.register_tool("tools:all_tool", {
	description = "All tool".."\n"..
		"All in One Tool",
	inventory_image = "all_tool.png",
	wield_scale = {x = 2, y = 2, z = .5},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 0,
		groupcaps={
			crumbly={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			snappy={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			choppy={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
		},
		damage_groups = {fleshy= 1},
	},
})

-------------------------------------------------------------------

local laser_item = "tools:freezeray"  
local laser_entity = "tools:ice_laser_beam"

-- Duration ice remains (in seconds)
local temp_ice_duration = 5

-- Nodes that shouldn't be frozen
local nodes_to_ignore = {
	["misc:node_1"] = true,
	["misc:node_2"] = true,
	["misc:node_3"] = true,
	["misc:node_4"] = true,
	["misc:node_5"] = true,
	["misc:node_6"] = true,
	["misc:node_7"] = true,
	["misc:node_8"] = true,
	["misc:node_9"] = true,
	["misc:node_10"] = true,
	["misc:node_11"] = true,
	["misc:node_12"] = true,
	["misc:node_13"] = true,
	["misc:node_0"] = true,
	["default:ice"] = true,
	["default:stone"] = true,
	["misc:torch"] = true,
	["misc:light_source"] = true,
	["misc:plane_light_source"] = true,
	["nodebox:node_1"] = true,
	["nodebox:node_2"] = true,
	["nodebox:node_3"] = true,
	["nodebox:node_4"] = true,
	["nodebox:node_5"] = true,
	["nodebox:node_6"] = true,
	["nodebox:node_7"] = true,
	["nodebox:node_8"] = true,
	["nodebox:node_9"] = true,
	["nodebox:node_10"] = true,
	["nodebox:node_11"] = true,
	["nodebox:node_12"] = true,
	["nodebox:node_13"] = true,

}

-- Helper: Replace a node with ice temporarily and restore it later
local function freeze_pos(pos)
	local node = minetest.get_node_or_nil(pos)
	if not node or nodes_to_ignore[node.name] then return end

	local original_node = node.name
	minetest.swap_node(pos, {name = "default:ice"})

	minetest.after(temp_ice_duration, function()
		if minetest.get_node(pos).name == "default:ice" then
			minetest.set_node(pos, {name = original_node})
		end
	end)
end

-- Register the laser beam entity
minetest.register_entity(laser_entity, {
    initial_properties = {
        physical = false,
        collide_with_objects = false,
        collisionbox = {0, 0, 0, 0, 0, 0},
        visual = "sprite",
        textures = {"laser_beam.png"},
        visual_size = {x = 0.2, y = 0.2},
        pointable = false,
    },

    timer = 0,
    range = 20,  -- Maximum range of the laser beam

    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        local pos = self.object:get_pos()

        -- Check for objects (entities) within a small radius along the laser's path
        local objects = minetest.get_objects_inside_radius(pos, 1)
        local hit_entity = false
        for _, obj in ipairs(objects) do
            if obj ~= self.object then
                local obj_pos = obj:get_pos()
                for i = -1, 1 do
                    for j = -1, 1 do
                        for k = -1, 1 do
                            local ice_pos = {
                                x = obj_pos.x + i,
                                y = obj_pos.y + j,
                                z = obj_pos.z + k
                            }
                            freeze_pos(ice_pos)
                        end
                    end
                end
                hit_entity = true
                break
            end
        end

        -- Replace nearby area with ice, regardless of entity detection
        if hit_entity or self.timer >= self.range / 10 then
            local range = 2  -- Radius for replacing nodes with ice
            for x = -range, range do
                for y = -range, range do
                    for z = -range, range do
                        local node_pos = vector.add(pos, {x = x, y = y, z = z})
                        freeze_pos(node_pos)
                    end
                end
            end
            self.object:remove()
        end
    end,
})

-- Register the Freeze Ray item
minetest.register_node("tools:freezeray", {
	description = "Freeze Ray\nFreezes when Used (WARNING: Affects players too!)",
	drawtype = 'mesh',
	mesh = 'freezeray.obj',
	tiles = {"freezeray.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3, crumbly = 3,},
	drop = "tools:freezeray",
	light_source = 5,
	tool_capabilities = {
		full_punch_interval = 0.5,
		damage_groups = {fleshy = 100},
	},
	on_use = function(itemstack, user, pointed_thing)
		local player_pos = user:get_pos()
		local dir = user:get_look_dir()

		-- Spawn the laser beam entity slightly in front of the player
		local start_pos = {
			x = player_pos.x + dir.x,
			y = player_pos.y + dir.y + 1.5,
			z = player_pos.z + dir.z
		}
		local obj = minetest.add_entity(start_pos, laser_entity)

		if obj then
			obj:set_velocity({
				x = dir.x * 30,
				y = dir.y * 30,
				z = dir.z * 30
			})
			obj:set_acceleration({x = 0, y = 0, z = 0})
		end

		if pointed_thing.type == "node" then
			local pos = pointed_thing.under
			if not nodes_to_ignore[minetest.get_node(pos).name] then
				freeze_pos(pos)
				minetest.sound_play("default_place_node", {pos = pos, gain = 0.5})
				itemstack:add_wear(65535 / 100)
			end
		end

		return itemstack
	end,
})

-----------------------------------------------------------------

minetest.register_node("tools:smart_phone", {
	description = "Smart Phone",
	drawtype = 'mesh',
	mesh = 'phone.obj',
	tiles = {"phone.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3,crumbly = 3,},
	drop = "tools:smart_phone",
	light_source =  7,
	})
	
-- Register the smartphone tool
minetest.register_node("tools:phone", {
	description = "📱 Soldier's Tactical Smartphone",
	drawtype = 'mesh',
	mesh = 'phone.obj',
	tiles = {"phone_UV2.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3,crumbly = 3,},
	drop = "tools:phone",
	light_source =  7,
	wield_image = "phone.png",
	inventory_image = "phone.png",
	wield_scale = {x = .5, y = 1, z = .5},
	stack_max = 1,
	collision_box = {
	type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, -0.5000, 0.5000},
	},
	selection_box = {
	type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, -0.5000, 0.5000},
	},
on_use = function(itemstack, user, pointed_thing)
	if user and user:is_player() then
		show_phone_formspec(user:get_player_name())
	end
	return itemstack
end,
on_secondary_use = function(itemstack, user, pointed_thing)
	if user and user:is_player() then
		show_phone_formspec(user:get_player_name())
	end
	return itemstack
end,
on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
	if clicker and clicker:is_player() then
		show_phone_formspec(clicker:get_player_name())
	end
	return itemstack
end,

})

-- Define the formspec function
function show_phone_formspec(player_name)
	local time = os.date("%H:%M")
	
	local formspec = [[
		formspec_version[4]
		size[12,10]
		box[0,0;12,10;#000000CC]
		
		// Notification bar
		box[0,0;12,0.6;#1a1a1a]
		label[0.4,0.1;]] .. time .. [[]
		label[5.2,0.1;🔔 ⚠️  📶  🔋]
		
		// Wallpaper
		image[0.5,0.6;11,2;phone_wallpaper.png]
		
		// Main interface
		label[0.5,2.6;Soldier Tactical Interface - Uplink OS 1.7.3]
		label[0.5,3.2;Status: 📡 Attempting to establish secure connection...]

		button[0.5,4;5.5,1;call;📞 Initiate Base Call]
		button[6,4;5.5,1;text;💬 Access Encrypted Messages]

		textarea[0.5,5.2;11,4;;Terminal Log:;
--- TACTICAL MISSION LOG ---

>> 0400 HRS: Patrol initiated from Outpost Delta.
>> 0500 HRS: No signs of enemy activity.
>> 0600 HRS: Unidentified sound detected northeast quadrant.
>> 0615 HRS: Visual contact. Unknown entity (code: BEAST) spotted.
>> 0640 HRS: Comm attempt failed. Signal jammed.
>> 0650 HRS: Engaged entity. Heavy resistance.
>> 0700 HRS: Unit Alpha incapacitated.
>> 0720 HRS: Base unreachable. Backup comm lost.

--- END LOG ---
		]

		button_exit[4.5,9.3;3,1;exit;📴 Power Down]
	]]
	minetest.show_formspec(player_name, "soldier_phone:interface", formspec)
end

-- Handle button logic
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "soldier_phone:interface" then return end
    local name = player:get_player_name()

    if fields.call then
        minetest.chat_send_player(name, "📞 Attempting to call base...")
        minetest.after(2, function()
            minetest.chat_send_player(name, "⚠️ Communications lost! Enemy jamming signals detected.")
        end)
    elseif fields.text then
        minetest.chat_send_player(name, "📩 [ENCRYPTED MESSAGE]: Hold position. Reinforcements delayed.")
        minetest.after(1.5, function()
            minetest.chat_send_player(name, "📩 [ENCRYPTED MESSAGE]: Extract immediately if overwhelmed.")
        end)
    end
end)

------------------------------------------------------------------	
minetest.register_node("tools:immortal_belt", {
	description = "Immortal Belt".."\n"..
	"Makes User Immortal when Used",
	drawtype = 'mesh',
	mesh = 'immortal_belt.obj',
	tiles = {"immortal_belt.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3,crumbly = 3,},
	drop = "tools:immortal_belt",
	light_source =  5,
	})

-- Function to check and update player's immortality status
local function update_player_immortality(player)
	local wielded_item = player:get_wielded_item():get_name()
    
--Check if the player is wielding the specific item
	if wielded_item == "tools:immortal_belt" then
		player:set_armor_groups({immortal = 1})  -- Set player to be immortal
	else
		player:set_armor_groups({fleshy = 100})  -- Reset to normal mortality
	end
end

-- Global step to continually check all players' wielded items
minetest.register_globalstep(function(dtime)
for _, player in ipairs(minetest.get_connected_players()) do
	update_player_immortality(player)
	end
end)
----------------------------------------------------------------------

-- Register the Scouter item
minetest.register_node("tools:scouter", {
	description = "Scouter\nDetects Life Force of entities when Used",
	inventory_image = "scouter_inv.png",
	wield_image = "scouter_inv.png",
	drawtype = 'mesh',
	mesh = 'scouter.obj',
	tiles = {"scouter_obj.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3, crumbly = 3},
	drop = "tools:scouter",
	light_source = 5,
})

-- Scouter detection parameters
local waypoint_item = "tools:scouter"
local range = 100  -- Range to detect nearby entities (in nodes)
local update_interval = 0.5  -- Update interval in seconds for checking nearby entities
local player_waypoints = {}

-- Function to add waypoints for nearby entities
local function update_waypoints_for_player(player)
	local player_name = player:get_player_name()
	local wielded_item = player:get_wielded_item():get_name()

	if wielded_item == waypoint_item then
		-- Remove existing waypoints first
		if player_waypoints[player_name] then
			for _, hud_id in ipairs(player_waypoints[player_name]) do
				player:hud_remove(hud_id)
			end
		end

		player_waypoints[player_name] = {}

		-- Get player position and find nearby entities
		local pos = player:get_pos()
		local entities = minetest.get_objects_inside_radius(pos, range)

		-- Add a waypoint for each nearby entity
		for _, entity in ipairs(entities) do
			-- Only add waypoints for players or entities with health
			if entity:is_player() then
				local entity_pos = entity:get_pos()
				local hp = entity:get_hp()

				-- If the entity is not immortal, show its health
				local show_hp = true
				if entity:get_luaentity() and entity:get_luaentity().immortal then
					-- If the entity has an 'immortal' field, and it's true, do not show health
					show_hp = false
				end

				-- Add health to the waypoint description if applicable
				local hud_text = "Player"
				if show_hp then
					hud_text = hud_text .. " (HP: " .. hp .. ")"
				end

				local hud_id = player:hud_add({
					hud_elem_type = "waypoint",
					name = "Player",
					number = 0xFF0000,  -- Red color for the waypoint
					world_pos = entity_pos,
					text = hud_text,  -- Show the health (if not immortal)
				})
				table.insert(player_waypoints[player_name], hud_id)
			elseif entity:get_luaentity() then
				-- If it's a custom entity with health (like a mob)
				local lua_entity = entity:get_luaentity()
				if lua_entity.health then
					local entity_pos = entity:get_pos()
					local hp = lua_entity.health
					local show_hp = true

					-- Check if the entity is immortal
					if lua_entity.immortal then
						show_hp = false
					end

					local hud_text = "Entity"
					if show_hp then
						hud_text = hud_text .. " (HP: " .. hp .. ")"
					end

					local hud_id = player:hud_add({
						hud_elem_type = "waypoint",
						name = "Entity",
						number = 0xFF0000,  -- Red color for the waypoint
						world_pos = entity_pos,
						text = hud_text,  -- Show the health (if not immortal)
					})
					table.insert(player_waypoints[player_name], hud_id)
				end
			end
		end
	else
		-- Remove waypoints if player is not wielding the item
		if player_waypoints[player_name] then
			for _, hud_id in ipairs(player_waypoints[player_name]) do
				player:hud_remove(hud_id)
			end
			player_waypoints[player_name] = nil
		end
	end
end

-- Global step to update waypoints every interval for all players
local time_elapsed = 0
minetest.register_globalstep(function(dtime)
	time_elapsed = time_elapsed + dtime
	if time_elapsed >= update_interval then
		time_elapsed = 0
		for _, player in ipairs(minetest.get_connected_players()) do
			update_waypoints_for_player(player)
		end
	end
end)

------------------------------------------------------------------------------
local throw_item = "tools:throw_bomb"  
local throw_entity = "tools:throw_bomb"

-- Register the throwable entity
minetest.register_entity(throw_entity, {
    initial_properties = {
        physical = true,
        collide_with_objects = true,
        collisionbox = {-1/2,-1/2,-1/2,1/2,1/2,1/2},
        visual = "mesh",
        mesh = "throw_bomb.b3d",
        textures = {"throw_bomb.png"},
        visual_size = {x = 5, y = 5},
    },

    timer = 0,  -- Add a timer property

    on_step = function(self, dtime)
        self.timer = self.timer + dtime  -- Increase the timer

        if self.timer >= 1 then  -- Check if 1 second has passed
            local pos = self.object:get_pos()
            local objects = minetest.get_objects_inside_radius(pos, 3)  -- Detection radius of 3

            for _, obj in ipairs(objects) do
                if obj ~= self.object then
                    local obj_pos = obj:get_pos()
                    local dir = vector.subtract(obj_pos, pos)  -- Direction vector from bomb to object
                    local distance = vector.length(dir)  -- Distance to object

                    -- Ensure the knockback is always at least 15 nodes away
                    if distance > 0 then
                        -- Apply knockback force (scaled to always push at least 15 nodes)
                        local knockback_force = vector.multiply(vector.normalize(dir), 15)
                        obj:set_velocity(knockback_force)  -- Apply knockback velocity
                    end
                end
            end

            self.object:remove()  -- Remove the thrown entity after 1 second
        end
    end,
})

minetest.register_node("tools:throw_bomb", {
    description = "Throw Bomb".."\n"..
    "Knocks Entities Away When Used",
    drawtype = 'mesh',
    mesh = 'throw_bomb.obj',
    tiles = {"throw_bomb.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3,crumbly = 3,},
    drop = "tools:throw_bomb",
    light_source = 5,
    
    on_use = function(itemstack, user, pointed_thing)
        local player_pos = user:get_pos()
        local dir = user:get_look_dir()
        local obj = minetest.add_entity({
            x = player_pos.x + dir.x,
            y = player_pos.y + dir.y + 1.5, -- Slightly above player's head
            z = player_pos.z + dir.z
        }, throw_entity)

        if obj then
            obj:set_velocity({
                x = dir.x * 10,
                y = dir.y * 10,
                z = dir.z * 10
            })
            obj:set_acceleration({x = 0, y = -9.8, z = 0}) -- Gravity
        end
    end,
})

--------------------------------------------------------
local laser_entity = "tools:laser_beam"

-- Protected nodes (not destroyed by laser)
local protected_nodes = {
	"misc:node_1",
	"misc:node_2",
	"misc:node_3",
	"misc:node_4",
	"misc:node_5",
	"misc:node_6",
	"misc:node_7",
	"misc:node_8",
	"misc:node_9",
	"misc:node_10",
	"misc:node_11",
	"misc:node_12",
	"misc:node_13",
	"misc:node_0",
	"default:ice",
	"default:stone",
	"misc:torch",
	"misc:light_source",
	"misc:plane_light_source",
	"nodebox:node_1",
	"nodebox:node_2",
	"nodebox:node_3",
	"nodebox:node_4",
	"nodebox:node_5",
	"nodebox:node_6",
	"nodebox:node_7",
	"nodebox:node_8",
	"nodebox:node_9",
	"nodebox:node_10",
	"nodebox:node_11",
	"nodebox:node_12",
	"nodebox:node_13",
}

-- Function to check if a node is protected
local function is_protected_node(name)
    for _, n in ipairs(protected_nodes) do
        if name == n then return true end
    end
    return false
end

-- Register the laser particle entity
minetest.register_entity(laser_entity, {
    initial_properties = {
        physical = false,
        collide_with_objects = false,
        collisionbox = {0, 0, 0, 0, 0, 0},
        visual = "sprite",
        textures = {"laser_beam.png"},
        visual_size = {x = 0.2, y = 0.2},
        pointable = false,
    },

    timer = 0,
    range = 2,  -- Time to live

    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        local pos = self.object:get_pos()

        -- Deal damage to nearby entities
        local objs = minetest.get_objects_inside_radius(pos, 1)
        for _, obj in ipairs(objs) do
            if obj ~= self.object and obj:is_player() == false then
                if obj:get_luaentity() or obj:is_player() then
                    local hp = obj:get_hp()
                    obj:set_hp(hp - 1)
                    if obj:get_hp() <= 0 then
                        obj:remove()
                    end
                end
            end
        end

        -- Destroy nearby nodes
        local node = minetest.get_node(pos)
        if node.name ~= "air" and not is_protected_node(node.name) then
            minetest.remove_node(pos)
        end

        if self.timer > self.range then
            self.object:remove()
        end
    end
})

-- Register the gun repulsor item
minetest.register_node("tools:gun_repulsor", {
	description = "Gun Repulsor".."\n"..
	"shoots laser particles that damage entities and destroy blocks".."\n"..
	"Warning! This does not works on Living Beings",
	drawtype = "mesh",
	mesh = "gun_repulsor.obj",
	tiles = {"gun_repulsor.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3, crumbly = 3},
	drop = "tools:gun_repulsor",
	light_source = 5,

	on_use = function(itemstack, user, pointed_thing)
	
	minetest.sound_play("knocker", {
            pos = user:get_pos(),
            gain = 1.0,
            max_hear_distance = 10
        })

	
	minetest.after(0, function()
            local timer = 0
            local max_duration = 2.0 -- seconds
            local interval = 0.1     -- seconds between each laser particle

            local function shoot_laser()
                if not user or not user:is_player() then return end
                timer = timer + interval
                if timer > max_duration then return end

                local dir = user:get_look_dir()
                local pos = user:get_pos()
                local start_pos = {
                    x = pos.x + dir.x,
                    y = pos.y + dir.y + 1.5,
                    z = pos.z + dir.z
                }

                local obj = minetest.add_entity(start_pos, laser_entity)
                if obj then
                    obj:set_velocity({
                        x = dir.x * 20,
                        y = dir.y * 20,
                        z = dir.z * 20
                    })
                end

                minetest.after(interval, shoot_laser)
            end

            shoot_laser()
        end)
    end,
})

local turbo_cooldowns = {} -- Track per-player cooldown
	
minetest.register_node("tools:knocker", {
	description = "Knocker\nLaunches entities in your look direction!\nSneak+On_Use (Activates TURBO MODE)",
	drawtype = 'mesh',
	mesh = 'knocker.obj',
	tiles = {"knocker.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3, crumbly = 3},
	drop = "tools:knocker",
	light_source = 5,

on_use = function(itemstack, user, pointed_thing)
	local name = user:get_player_name()
	local controls = user:get_player_control()

        minetest.sound_play("knocker", {
            pos = user:get_pos(),
            gain = 1.0,
            max_hear_distance = 10
        })


	if controls.sneak then
		if turbo_cooldowns[name] and turbo_cooldowns[name] > minetest.get_gametime() then
			minetest.chat_send_player(name, "⏳ Turbo Mode is on cooldown.")
			return itemstack
		end

		-- Create turbo item and set activation time
		local turbo_stack = ItemStack("tools:knocker_turbo")
		local meta = turbo_stack:get_meta()
		meta:set_string("activated_at", tostring(minetest.get_gametime()))

		itemstack:replace(turbo_stack)
		turbo_cooldowns[name] = minetest.get_gametime() + 10 -- 5s active + 5s cooldown

		minetest.chat_send_player(name, "⚡ Turbo Mode Activated!")

		-- After 5 seconds, revert back to normal
		minetest.after(5, function()
			local player = minetest.get_player_by_name(name)
			if player then
				local wield = player:get_wielded_item()
				if wield:get_name() == "tools:knocker_turbo" then
					player:set_wielded_item("tools:knocker")
					minetest.chat_send_player(name, "🔋 Turbo Mode ended.")
				end
			end
		end)

		return itemstack
	end

	-- Normal knockback logic if not sneaking
	local pos = user:get_pos()
	local dir = user:get_look_dir()
	local origin = vector.add(pos, vector.multiply(dir, 2))
	local knockback_force = 50
	local range = 6

	for _, obj in ipairs(minetest.get_objects_inside_radius(origin, range)) do
		if obj ~= user and (obj:is_player() or obj:get_luaentity()) then
			local blast = vector.multiply(dir, knockback_force)
			obj:add_velocity(blast)
		end
	end

	return itemstack
end,
})


minetest.register_node("tools:knocker_turbo", {
	description = "Knocker (TURBO MODE)\nLaunches entities in your look direction!",
	drawtype = 'mesh',
	mesh = 'knocker.obj',
	tiles = {"knocker_turbo.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 3, crumbly = 3},
	drop = "tools:knocker",
	light_source = 5,
	on_use = function(itemstack, user, pointed_thing)
		local meta = itemstack:get_meta()
		local activated = tonumber(meta:get_string("activated_at")) or 0
		local now = minetest.get_gametime()
		
	minetest.sound_play("knocker", {
            pos = user:get_pos(),
            gain = 1.0,
            max_hear_distance = 10
        })


		-- Auto revert if 5s expired
		if now - activated > 5 then
			itemstack:replace("tools:knocker")
			return itemstack
		end

		-- Turbo effect
		local pos = user:get_pos()
		local dir = user:get_look_dir()
		local origin = vector.add(pos, vector.multiply(dir, 2))
		local knockback_force = 2000
		local range = 6

		for _, obj in ipairs(minetest.get_objects_inside_radius(origin, range)) do
			if obj ~= user and (obj:is_player() or obj:get_luaentity()) then
				local blast = vector.multiply(dir, knockback_force)
				obj:add_velocity(blast)
			end
		end

		minetest.chat_send_player(user:get_player_name(), "💥 Turbo Punch!")
		return itemstack
	end,

	-- Handle reversion when placed (as a safety)
	on_place = function(itemstack, placer, pointed_thing)
		local meta = itemstack:get_meta()
		local activated = tonumber(meta:get_string("activated_at")) or 0
		local now = minetest.get_gametime()

		if now - activated > 5 then
			itemstack:replace("tools:knocker")
		end
		return itemstack
	end,

	-- Set activation timestamp when tool is created/switched
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("activated_at", tostring(minetest.get_gametime()))
	end,
})

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	local wielded = player:get_wielded_item()

	if wielded:get_name() == "tools:knocker_turbo" then
		wielded:replace("tools:knocker")
		player:set_wielded_item(wielded)
		minetest.log("action", "[Knocker] Turbo mode auto-disabled for "..name)
	end
end)


