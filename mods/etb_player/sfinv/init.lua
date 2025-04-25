-- sfinv/init.lua

dofile(minetest.get_modpath("sfinv") .. "/api.lua")

-- Load support for MT game translation.
local S = minetest.get_translator("sfinv")

sfinv.register_page("sfinv:crafting", {
	title = S("Inventory"),
	get = function(self, player, context)
		return sfinv.make_formspec(player, context, [[
position[0.5,0.5]

list[current_player;main; 4.7,0.38;3,9;]

model[0,0;5,5;player;sam.obj;character.png;0,0]

image[-0.30,-0.3;10.6,12;inv_img.png]

label[1.5,5;Identity Card]
label[1.5,5;Identity Card]
label[1.5,5;Identity Card]
label[1.5,5;Identity Card]

label[0.5,5.5;Code Name: K_10]
label[0.5,6;Full Name: Nindaka Nashakay]
label[0.5,6.5;Date of Birth: April 30, 2898 AD]
label[0.5,7;Age: 42 years]
label[0.5,7.5;Gender: Male] 
label[0.5,8;Rank: Commander]
label[0.5,8.5;Faction:United Nation Defense(UND)]  

			]], true)
	end
})

minetest.register_on_joinplayer(function(player)
	-- Set HUD hotbar to 9 slots (default is 8)
	player:hud_set_hotbar_itemcount(9)

	-- (Optional but recommended) Set hotbar image background to fit 9 slots
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
end)

