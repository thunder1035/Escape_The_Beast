-- Table to store registered items and their HUD information
local hud_items = {}

-- Function to register an item with HUD details
function register_hud_item(item_name, def)
    hud_items[item_name] = {
        hud_texture = def.hud_texture,
        sound_on = def.sound_on or nil,
        sound_off = def.sound_off or nil,
        animated = def.animated or false
    }
end

-- Function to display HUD for a wielded item
local function show_hud(player, item_name)
    local player_name = player:get_player_name()
    local item_def = hud_items[item_name]

    -- If no HUD texture is defined, skip
    if not item_def or not item_def.hud_texture then
        return nil
    end

    -- Play the "on" sound, if defined
    if item_def.sound_on then
        minetest.sound_play(item_def.sound_on, {to_player = player_name})
    end

    -- Display HUD
    return player:hud_add({
        hud_elem_type = "image",
        position = {x = 0.5, y = 0.5},
        offset = {x = 0, y = 0},
        text = item_def.hud_texture,
        scale = {x = 5, y = 5},
        alignment = {x = 0, y = 0},
    })
end

-- Function to hide HUD and play the "off" sound
local function hide_hud(player, hud_id, item_name)
    if hud_id then
        player:hud_remove(hud_id)
    end

    -- Play the "off" sound, if defined
    local item_def = hud_items[item_name]
    if item_def and item_def.sound_off then
        minetest.sound_play(item_def.sound_off, {to_player = player:get_player_name()})
    end
end

-- Track HUD for each player
local player_huds = {}

-- Update HUD based on the wielded item
minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local player_name = player:get_player_name()
        local wielded_item = player:get_wielded_item():get_name()
        
        -- Check if the wielded item has a registered HUD
        if hud_items[wielded_item] then
            -- Show HUD if it's not already active
            if not player_huds[player_name] or player_huds[player_name].item_name ~= wielded_item then
                if player_huds[player_name] then
                    -- Hide the previous HUD if switching items
                    hide_hud(player, player_huds[player_name].hud_id, player_huds[player_name].item_name)
                end
                
                -- Show new HUD
                local hud_id = show_hud(player, wielded_item)
                player_huds[player_name] = {hud_id = hud_id, item_name = wielded_item}
            end
        else
            -- If wielded item is not registered, hide any existing HUD
            if player_huds[player_name] then
                hide_hud(player, player_huds[player_name].hud_id, player_huds[player_name].item_name)
                player_huds[player_name] = nil
            end
        end
    end
end)

register_hud_item("tools:scouter", {
    hud_texture = "scouter.png",
    sound_on = "magic_wand_activate",
    sound_off = "magic_wand_deactivate",
    animated = false  -- Set to true if you want to handle animations separately
})

register_hud_item("tools:immortal_belt", {
    hud_texture = "immortal_belt_hud.png",
    sound_on = "magic_wand_activate",
    sound_off = "magic_wand_deactivate",
    animated = false  -- Set to true if you want to handle animations separately
})

register_hud_item("tools:freezeray", {
    hud_texture = "freezeray_aim.png",
    sound_on = "magic_wand_activate",
    sound_off = "magic_wand_deactivate",
})

register_hud_item("tools:gun_repulsor", {
    hud_texture = "gun_repulsor_aim.png",
    sound_on = "magic_wand_activate",
    sound_off = "magic_wand_deactivate",
})

---------------------------------------------


local player_entities = {}


minetest.register_tool("item_hud:toggle_gun", {
    description = "Toggle Gun",
    inventory_image = "toggle_gun.png",

    on_use = function(itemstack, player, pointed_thing)
        local player_name = player:get_player_name()

        -- Check if the entity is already attached
        if player_entities[player_name] then
            -- Detach the entity by removing it
            player_entities[player_name]:remove()
            player_entities[player_name] = nil
            minetest.chat_send_player(player_name, "Gun detached.")
        else
            -- Attach a new gun entity to the player
            local gun_entity = minetest.add_entity(player:get_pos(), "item_hud:gun")
            gun_entity:set_attach(player, "", {x = 0, y = 6, z = 0}, {x = 0, y = 0, z = 0})
            
            player_entities[player_name] = gun_entity
            minetest.chat_send_player(player_name, "Gun attached.")
        end

        return itemstack
    end,
})

minetest.register_entity("item_hud:gun", {
    initial_properties = {
        physical = false,
        collide_with_objects = false,
        pointable = false,
        visual = "mesh",
        mesh = "beast_armor.obj",  -- Change to your gun model file
        textures = {"default_stone.png"},  -- Change to your gun texture file
        visual_size = {x = 12.5, y = 12.5},  -- Adjust size as necessary
    },
})
---------------------------------------------------------------------
local look_display = {}
look_display.registered_nodes = {}

function look_display.register_node(node_name, message)
	look_display.registered_nodes[node_name] = message
end

-- Function to check what node the player is looking at and display the message
local function show_looked_at_node(player)
	local player_pos = player:get_pos()
	local look_dir = player:get_look_dir()
	local ray_pos = vector.add(player_pos, vector.new(0, player:get_properties().eye_height, 0))

-- Cast a ray in the direction the player is looking
	local ray = minetest.raycast(ray_pos, vector.add(ray_pos, vector.multiply(look_dir, 10)), true, false)
	for pointed_thing in ray do
		if pointed_thing.type == "node" then
	local node_pos = pointed_thing.under
	local node = minetest.get_node(node_pos)

-- Check if the node is registered with a custom message
	local message = look_display.registered_nodes[node.name]
		if message then
-- Display the custom message in the player's chat
	minetest.chat_send_player(player:get_player_name(), message)

	end
		break
		end
	end
end

local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= 0.25 then
        timer = 0
        for _, player in ipairs(minetest.get_connected_players()) do
            show_looked_at_node(player)
        end
    end
end)

-- Example usage of the API
look_display.register_node("misc:pyramid_gate_upper_og", "Click To Open")
look_display.register_node("misc:spaceship_gate_left_og", " [Weapons closet] Click To Open")
look_display.register_node("misc:spaceship_gate_right_og", " [Weapons closet] Click To Open")

