-- Store form data and player progress
local player_story_progress = {}


-- Define story data with images and text
local story_pages = {
{image = "story_image_1.png", 
text = "You are part of an elite rescue team sent deep into the jungle to investigate" .. 
"\n" ..
"\n" ..
"\n" ..
"a series of brutal attacks on local villages. The villagers whisper of a BEAST a" ..
"\n" ..
"\n" ..
"\n" ..
"relentless predator hunting them one by one, Your mission was to rescue survivors and" ..
"\n" ..
"\n" ..
"\n" ..
"eliminate the threat..."
},

{image = "story_image_2.png", 
text = "Deeper into the jungle, your team is ambushed. Communication with base is comprimised" .. 
"\n" ..
"\n" ..
"\n" ..
"Unseen movements in the shadows, piercing screams in the dark..." ..
"\n" ..
"\n" ..
"\n" ..
"This is no ordinary predator."
},

{image = "story_image_3.png", 
text = "You were sent to hunt. Now, you are hunted." .. 
"\n" ..
"\n" ..
"\n" ..
"Survival is your only mission" ..
"\n" ..
"\n" ..
"\n" ..
"ESCAPE THE BEAST or Make BEAST ESCAPE while waiting for backup… if it ever comes..."
},
}

-- Function to show the form for a specific page
local function show_story_form(player, page)
    local player_name = player:get_player_name()
    
    -- Check if it's the last page
    local is_last_page = (page >= #story_pages)

    -- Set up form with image and text, plus navigation buttons
    local formspec = "formspec_version[4]" ..
                     "size[65,40]" ..
                     "image[2,2;60,30;" .. story_pages[page].image .. "]" ..  -- Large image
                     "label[1,33.5;" .. minetest.formspec_escape(story_pages[page].text) .. "]"  -- Label for story text

    if is_last_page then
        formspec = formspec .. "button_exit[58,33;5,1;close;Close]"
    else
        formspec = formspec .. "button[58,33;5,1;next;Next]"
    end
    
    formspec = formspec .. "button_exit[51,33;5,1;skip;Skip]"

    minetest.show_formspec(player_name, "story:form", formspec)

    -- Save player progress
    player_story_progress[player_name] = page
end

-- Register on-join event for new players
minetest.register_on_newplayer(function(player)
    show_story_form(player, 1)  -- Start from page 1 on first join
end)

-- Register command for viewing the story form
minetest.register_chatcommand("story", {
    description = "View the story again",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player then
            show_story_form(player, 1)
        end
    end,
})

-- Handle form input for navigation
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "story:form" then
        local player_name = player:get_player_name()
        local current_page = player_story_progress[player_name] or 1

        if fields.next then
            -- Show the next page
            show_story_form(player, current_page + 1)
        elseif fields.close or fields.skip then
            -- Close the form and reset progress
            player_story_progress[player_name] = nil
        end
    end
end)

