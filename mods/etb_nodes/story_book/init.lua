local story_pages = {
    "Long ago, during times of peace, a group of beasts hunters, came from the sky",
    "They enslaved our people for many years, treating us as nothing more than prey.....",
    "But it wasn’t long before our ancestors rebelled. Despite their bravery, the rebellion had no effect.",
    "In retaliation, the beast hunters began torturing and killing us, one by one, in brutal ways.",
    "Desperate, our people begged for forgiveness. A truce was made...",
    "Every hundred years, one of their beast warriors would come to test its hunting skills. It would hunt alone, and a warrior from our side would be chosen as the sacrifice.",
    "If we failed to put up a challenge, the beast would slaughter us all. But if we could defeat it, they promised to leave us in peace forever.",
    "It's been 5000 years and after every century, a new beast warrior came and each time, our chosen warrior failed.",
    "The battle always took place in the ancient temple, and none survived to tell the tale....",
    "Now, another hundred years has passed. But this time, our warrior gave up before the fight even began.",
    "With no sacrifice to challenge, the beast turned on our village, killing our people one by one.",
    "We sent calls for help across the world—but none who came survived...",
    "Now, only one hope remains: someone must rise and slay the beast in the ancient temple.",
    "If we all perish, the sky hunters will return to destroy our entire world. To save humanity, a new warrior must rise! \nHelping us to Escape the Beast. ",
}

local function get_formspec(page)
    local image = "book_page_" .. page .. ".png"
    local text = story_pages[page]

    return "formspec_version[4]" ..
           "size[25,15]" ..
           "bgcolor[#000000DD;true]" ..
           "image[2,1;21,10;" .. image .. "]" ..
           "textarea[2,11.3;21,3.2;;;" .. minetest.formspec_escape(text) .. "]" ..
           "button[8,14;2,1;prev;<< Prev]" ..
           "label[12,14.3;" .. page .. "/" .. #story_pages .. "]" ..
           "button[15,14;2,1;next;Next >>]" ..
           "button_exit[20,14;3,1;exit;Close Book]"
end


minetest.register_node("story_book:lore_book", {
    description = "Lore Of The Beast",
    drawtype = "mesh",
    mesh = "book_3.obj",
    wield_image = "book_cover.png",
    inventory_image = "book_cover.png",
    tiles = {"book.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
    collision_box = {
    type = "fixed",
    fixed = {-0.5000, -0.5000, -0.5000, 0.5000, -0.5000, 0.5000},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local player_name = clicker:get_player_name()
        clicker:get_meta():set_string("story_book:page", "1")
        minetest.show_formspec(player_name, "story_book:book", get_formspec(1))
    end,
    on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("infotext", "Lore Of The Beast")
	end

})


minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "story_book:book" then return end
    if fields.exit then return end -- this line closes the formspec properly

    local name = player:get_player_name()
    local meta = player:get_meta()
    local page = tonumber(meta:get_string("story_book:page")) or 1

    if fields.next and page < #story_pages then
        page = page + 1
    elseif fields.prev and page > 1 then
        page = page - 1
    end

    meta:set_string("story_book:page", tostring(page))
    minetest.show_formspec(name, "story_book:book", get_formspec(page))
end)

