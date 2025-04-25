give_initial_stuff=true

minetest.register_on_newplayer(function(player)
	local inv=player:get_inventory()
	inv:add_item("main","tools:knocker")
	inv:add_item("main","tools:all_tool")
	inv:add_item("main","mtfoods:medicine")
	inv:add_item("main","cyber_car:cyber_car")
	inv:add_item("main","misc:map_item")
	inv:add_item("main","misc:mission_log")
	inv:add_item("main","walkman:walkman")
	inv:add_item("main","tools:phone")
	

end)

