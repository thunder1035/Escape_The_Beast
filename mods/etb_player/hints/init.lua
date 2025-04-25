local hints = {
    "Those noise... came from the Beast.",
    "To know history of the village, read Lore Of The Beast situated in village",
    "You might need to find much more powerful tool than yours to Defeat the Beast",
    "Spaceship Belongs to the Beast! ",
    "Avoid open areas, the Beast sees everything.",
}

local player_hint_timers = {}

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()

        -- Init timer if not set
        if not player_hint_timers[name] then
            player_hint_timers[name] = {
                time_left = math.random(60, 120)
            }
        end

        local data = player_hint_timers[name]
        data.time_left = data.time_left - dtime

        if data.time_left <= 0 then
            -- Send a random hint
            local hint = hints[math.random(1, #hints)]
            minetest.chat_send_player(name, minetest.colorize("#FFD700", "[Hint] ") .. hint)

            -- Reset timer with random interval
            data.time_left = math.random(60, 120)
        end
    end
end)

minetest.register_chatcommand("hint", {
    description = "Get a helpful hint",
    func = function(name)
        local hint = hints[math.random(1, #hints)]
        minetest.chat_send_player(name, minetest.colorize("#FFD700", "[Hint] ") .. hint)
    end,
})
