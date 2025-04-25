core.register_entity("beast:blast", {
    initial_properties = {
        physical = true,
        collide_with_objects = true,
        collisionbox = {0, 0, 0, 0, 0, 0},
        visual = "sprite",
        textures = {"blast.png"},
        velocity = 500,
        damage = 1,
        glow = 10,
    },

on_step = function(self, dtime)
    local pos = self.object:get_pos()
    local objs = core.get_objects_inside_radius(pos, 2)
    for _, obj in ipairs(objs) do
        if obj:is_player() then
            local player_pos = obj:get_pos()
            local blast_pos = self.object:get_pos()
            local dir = vector.direction(blast_pos, player_pos)

            -- 🚀 Powerful knockback
            local knockback = vector.multiply(dir, 250)
            knockback.y = 10  -- vertical lift
            obj:add_velocity(knockback)

            -- 💥 Initial blast smoke burst
            core.add_particlespawner({
                amount = 20,
                time = 0.1,
                minpos = vector.subtract(pos, 0.5),
                maxpos = vector.add(pos, 0.5),
                minvel = {x = -2, y = 1, z = -2},
                maxvel = {x = 2, y = 3, z = 2},
                minacc = {x = 0, y = -1, z = 0},
                maxacc = {x = 0, y = -1, z = 0},
                minexptime = 0.5,
                maxexptime = 1.5,
                minsize = 2,
                maxsize = 5,
                texture = "smoke.png",
                glow = 5,
            })

            -- 🔥 Smoke trail follows player
            local follow_time = 1.5
            local interval = 0.1
            local steps = math.floor(follow_time / interval)
            local player_ref = obj
            local count = 0

            local function spawn_trailing_smoke()
    if not player_ref or not player_ref:is_player() then return end

    local pos = vector.add(player_ref:get_pos(), {x = 0, y = 1, z = 0}) -- head level
    core.add_particlespawner({
        amount = 8,
        time = 0.05,
        minpos = pos,
        maxpos = pos,
        minvel = {x = -0.1, y = 0.2, z = -0.1},
        maxvel = {x = 0.1, y = 0.5, z = 0.1},
        minacc = {x = 0, y = -0.3, z = 0},
        maxacc = {x = 0, y = -0.1, z = 0},
        minexptime = 1,
        maxexptime = 2,
        minsize = 3,
        maxsize = 6,
        texture = "smoke.png",
        glow = 8,
    })

    count = count + 1
    if count < steps then
        core.after(interval, spawn_trailing_smoke)
    end
end

            spawn_trailing_smoke()

            -- ⚠️ Optional damage
            obj:set_hp(obj:get_hp() - 1)

            -- 💨 Remove blast object
            self.object:remove()
            return
        end
    end
end

})

-- Inactive watcher node
minetest.register_node("beast:watcher_node", {
    description = "Watcher Node",
    tiles = {"transparent.png"},
    use_texture_alpha = "blend",
    groups = {cracky = 3},
    on_construct = function(pos)
        minetest.get_node_timer(pos):start(0.25)
    end,
    on_timer = function(pos)
        local radius = 25
        local objects = minetest.get_objects_inside_radius(pos, radius)

        for _, obj in ipairs(objects) do
            if obj:is_player() then
                -- Transform to activated node
                minetest.set_node(pos, {name = "beast:beast"})
                return false -- Stop timer
            end
        end

        return true -- Continue checking
    end,
})

core.register_node("beast:beast", {
    description = "Beast Detector",
    drawtype = "mesh",
    mesh = "beast_node_2.obj",
    tiles = {"beast.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3},
    use_texture_alpha = "clip",

    on_construct = function(pos)
        core.get_node_timer(pos):start(0.5)
    end,

    on_timer = function(pos, elapsed)
        local radius = 20
        local objs = core.get_objects_inside_radius(pos, radius)

        for _, obj in ipairs(objs) do
            if obj:is_player() then
                local dir = vector.direction(pos, obj:get_pos())
                local spawn_pos = vector.add(pos, {x = 0, y = 1.2, z = 0})
                local velocity = vector.multiply(dir, 20)

                local ent = core.add_entity(spawn_pos, "beast:blast")
                if ent then
                    ent:set_velocity(velocity)
                end

                core.sound_play("energy_blast", {
                    pos = pos,
                    gain = 1.0,
                    max_hear_distance = 25,
                })

                -- Swap to animation node then air
                core.after(1.0, function()
                    core.set_node(pos, {name = "beast:blast_effect"})
                end)
                return false
            end
        end

        return true  -- Check again in next timer loop
    end,
})

core.register_node("beast:blast_effect", {
    description = "Blast Effect",
    drawtype = "mesh",
    mesh = "beast_node_2.obj",
    tiles = {"beast_invisible.png"},
    use_texture_alpha = "blend",
    paramtype = "light",
    groups = {not_in_creative_inventory = 1},

    -- When the node is placed, start a timer
    on_construct = function(pos)
        minetest.get_node_timer(pos):start(1.0)  -- 1 second
    end,

    -- When the timer expires, remove the node (turn it into air)
    on_timer = function(pos, elapsed)
        minetest.set_node(pos, {name = "air"})
    end,
})

core.register_node("beast:dummy", {
    description = "Beast Dummy",
    drawtype = "mesh",
    mesh = "beast_node_2.obj",
    tiles = {"beast.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    groups = {oddly_breakable_by_hand = 3},

    -- When the node is placed, start a timer
    on_construct = function(pos)
        minetest.get_node_timer(pos):start(5.0)  -- 1 second
    end,

    -- When the timer expires, remove the node (turn it into air)
    on_timer = function(pos, elapsed)
        minetest.set_node(pos, {name = "beast:watcher_node"})
    end,
})

local sound_list = {
    "beast_sound_1",
    "beast_sound_2",
    "beast_sound_3",
    "beast_sound_4",
    "beast_sound_5",
}

-- ABM: check every 3 seconds
minetest.register_abm({
    label = "Proximity Sound",
    nodenames = {"beast:beast"},
    interval = 1,
    chance = 1,
    action = function(pos)
        local players = minetest.get_connected_players()
        for _, player in ipairs(players) do
            local ppos = player:get_pos()
            if ppos and vector.distance(pos, ppos) <= 60 then
                local sound = sound_list[math.random(1, #sound_list)]
                minetest.sound_play(sound, {
                    pos = pos,
                    max_hear_distance = 50,
                    gain = 5,
                })
                break
            end
        end
    end,
})
