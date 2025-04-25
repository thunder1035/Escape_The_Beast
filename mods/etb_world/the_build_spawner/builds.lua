---------mts/we---------------
---------------length,breadth,height--------
------minetest.place_schematic-------

minetest.register_craftitem("the_build_spawner:tower_1", {
	description = "Tower_1",
	_tt_help = ("length(7), breadth(5), height(22)"),
	inventory_image = "tower.png",
	on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/tower_1.we")
		local value = file:read("*a")
		file:close()

		p.y = p.y - 1
		p.x = p.x - 3
		p.z = p.z - 2
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:tower_2", {
	description = "Tower_2",
	_tt_help = ("length(6),breadth(6),height(25)"),
	inventory_image = "tower.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/tower_2.we")
		local value = file:read("*a")
		file:close()

		p.y = p.y - 1
		p.x = p.x - 2
		p.z = p.z - 2
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:tower_3", {
	description = "Tower_3",
	_tt_help = ("length(5),breadth(5),height(24)"),
	inventory_image = "tower.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/tower_3.we")
		local value = file:read("*a")
		file:close()

		p.y = p.y - 1
		p.x = p.x - 2
		p.z = p.z - 2
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:tower_4", {
	description = "Tower_4",
	_tt_help = ("length(10),breadth(10),height(31)"),
	inventory_image = "tower.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/tower_4.we")
		local value = file:read("*a")
		file:close()

		p.y = p.y - 1
		p.x = p.x - 3
		p.z = p.z - 2
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})
minetest.register_craftitem("the_build_spawner:school", {
	description = "School",
	_tt_help = ("length(31),breadth(13),height(14)"),
	inventory_image = "assets.png",
	on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/school.we")
		local value = file:read("*a")
		file:close()

		p.y = p.y - 1
		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:house_1", {
	description = "house_1",
	_tt_help = ("length(23),breadth(23),height(22)"),
	inventory_image = "house.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/house_1.we")
		local value = file:read("*a")
		file:close()

		p.y = p.y - 1
		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:house_2", {
	description = "house_2",
	_tt_help = ("length(17),breadth(13),height(11)"),
	inventory_image = "house.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/house_2.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:bank", {
	description = "bank",
	_tt_help = ("length(16),breadth(16),height(14)"),
	inventory_image = "assets.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/bank.we")
		local value = file:read("*a")
		file:close()

		p.y = p.y - 1
		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})
	

minetest.register_craftitem("the_build_spawner:minishop_north", {
	description = "minishop(north_facing)",
	_tt_help = ("length(18),breadth(6),height(5)"),
	inventory_image = "shop.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/mini_shop(north_facing).we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})
minetest.register_craftitem("the_build_spawner:minishop_south", {
	description = "minishop(south_facing)",
	_tt_help = ("length(18),breadth(6),height(5)"),
	inventory_image = "shop.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/mini_shop(south_facing).we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})
minetest.register_craftitem("the_build_spawner:minishop_west", {
	description = "minishop(west_facing)",
	_tt_help = ("length(18),breadth(6),height(5)"),
	inventory_image = "shop.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/mini_shop(west_facing).we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:minishop_east", {
	description = "minishop(east_facing)",
	_tt_help = ("length(18),breadth(6),height(5)"),
	inventory_image = "shop.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/mini_shop(east_facing).we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:bakery", {
	description = "bakery",
	_tt_help = ("length(18),breadth(17),height(9)"),
	inventory_image = "assets.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/bakery.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:police_station", {
	description = "Police station",
	_tt_help = ("length(24),breadth(14),height(8)"),
	inventory_image = "assets.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/police_station.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})
minetest.register_craftitem("the_build_spawner:hotel", {
	description = "Hotel",
	_tt_help = ("length(41),breadth(33),height(28)"),
	inventory_image = "assets.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/hotel.we")
		local value = file:read("*a")
		file:close()
		
		p.y = p.y - 1
		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:church", {
	description = "Church",
	_tt_help = ("length(12),breadth(11),height(20)"),
	inventory_image = "assets.png",
	on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/church.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:restraunt", {
	description = "Restraunt",
	_tt_help = ("length(24),breadth(13),height(9)"),
	inventory_image = "assets.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/restraunt.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:hospital", {
	description = "Hospital",
	_tt_help = ("length(31),breadth(18),height(16)"),
	inventory_image = "assets.png",
	on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/hospital.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:cemetery", {
	description = "Cemetery",
	_tt_help = ("length(19),breadth(16),height(10)"),
	inventory_image = "assets.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/cemetery.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})
minetest.register_craftitem("the_build_spawner:mall", {
	description = "Mall",
	_tt_help = ("length(55),breadth(42),height(11)"),
	inventory_image = "shop.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/mall.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})


-------luxury_decor-------

if minetest.get_modpath("luxury_decor") then
	
minetest.register_craftitem("the_build_spawner:house_3", {
	description = "house_3",
	_tt_help = ("length(17),breadth(16),height(7)"),
	inventory_image = "house.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/house_3.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})
end

---------------------------------------------------

minetest.register_craftitem("the_build_spawner:tree_0", {
	description = "tree_0",
	inventory_image = "default_emergent_jungle_sapling.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/tree_0.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:tree_1", {
	description = "tree_1",
	inventory_image = "default_emergent_jungle_sapling.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/tree_1.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:tree_2", {
	description = "tree_2",
	inventory_image = "default_emergent_jungle_sapling.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/tree_2.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:tree_3", {
	description = "tree_3",
	inventory_image = "default_emergent_jungle_sapling.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/tree_3.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})

minetest.register_craftitem("the_build_spawner:tree_4", {
	description = "tree_4",
	inventory_image = "default_emergent_jungle_sapling.png",
		on_place = function(itemstack, placer, pointed_thing)
		if not placer or not pointed_thing.above then
			return itemstack
		end
		
		local pos = pointed_thing.above
		local p = placer:get_pos()  -- Get the placer's position
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")  -- Assume you store owner info in metadata
		
		if minetest.is_protected(pos, placer:get_player_name())
		   or (owner ~= "" and owner ~= placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "You don't have permission to build here.")
			return itemstack
		end

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/tree_4.we")
		local value = file:read("*a")
		file:close()

		p.x = p.x - 0
		p.z = p.z - 0
		local count = worldedit.deserialize(pos, value)
		itemstack:take_item()

		return itemstack
	end,
})
