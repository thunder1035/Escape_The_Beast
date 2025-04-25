The Build Spawner-
Mod that gives players The Build Spawner's to spawn build

How to add build 
---code---
minetest.register_craftitem("the_build_spawner:build_name", {
	description = "build description",
	inventory_image = "build.png",
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

		local file = io.open(minetest.get_modpath("the_build_spawner").."/schemes/build_file_name.we")
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
--------------

For add build do as following-
1)insert your Build_name in "minetest.register_craftitem"
2)Insert you build description or your build_name in description
3)Insert file nameto locate you file like this
(minetest.get_modpath("the_build_spawner").."/schemes/build_file_name.we")

leave all code same, for your build to be added,just rename your builds name as you want .
