local texture = {"ancient_brick.png"}
local group = {}
local node = {
	type = "fixed",
	fixed = {
		{-1/2,-1/2,-1/2,1/2,1/2,1/2}
	}
}

local node_stair = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		{-0.5, 0, 0, 0.5, 0.5, 0.5},
	}
}

local node_slab = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	}
}

local node_inner_stair = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
		{-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},

	}
}

local node_outer_stair = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
		{-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},

	}
}

local slope_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
}

local slope_cbox_long = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5,   -1.5,  0.5, -0.375, 0.5},  --  NodeBox1
		{-0.5, -0.375, -1.25, 0.5, -0.25,  0.5},  --  NodeBox2
		{-0.5, -0.25,  -1,    0.5, -0.125, 0.5},  --  NodeBox3
		{-0.5, -0.125, -0.75, 0.5,  0,     0.5},  --  NodeBox4
		{-0.5,  0,     -0.5,  0.5,  0.125, 0.5},  --  NodeBox5
		{-0.5,  0.125, -0.25, 0.5,  0.25,  0.5},  --  NodeBox6
		{-0.5,  0.25,   0,    0.5,  0.375, 0.5},  --  NodeBox7
		{-0.5,  0.375,  0.25, 0.5,  0.5,   0.5},  --  NodeBox8
	}
}

local icorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, -- NodeBox5
		{-0.5, -0.5, -0.25, 0.5, 0, 0.5}, -- NodeBox6
		{-0.5, -0.5, -0.5, 0.25, 0, 0.5}, -- NodeBox7
		{-0.5, 0, -0.5, 0, 0.25, 0.5}, -- NodeBox8
		{-0.5, 0, 0, 0.5, 0.25, 0.5}, -- NodeBox9
		{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5}, -- NodeBox10
		{-0.5, 0.25, -0.5, -0.25, 0.5, 0.5}, -- NodeBox11
	}
}

local ocorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
		{-0.5,     0,     0,     0,  0.25, 0.5},
		{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5}
	}
}

local short_pyr_cbox = {
	type = "fixed",
	fixed = {
		{ -0.5,   -0.5,   -0.5,   0.5,   -0.375, 0.5 },
		{ -0.375, -0.375, -0.375, 0.375, -0.25,  0.375},
		{ -0.25,  -0.25,  -0.25,  0.25,  -0.125, 0.25},
		{ -0.125, -0.125, -0.125, 0.125,  0,     0.125}
	}
}

local tall_pyr_cbox = {
	type = "fixed",
	fixed = {
		{ -0.5,   -0.5,  -0.5,   0.5,  -0.25, 0.5 },
		{ -0.375, -0.25, -0.375, 0.375, 0,    0.375},
		{ -0.25,   0,    -0.25,  0.25,  0.25, 0.25},
		{ -0.125,  0.25, -0.125, 0.125, 0.5,  0.125}
	}
}

local slope_fronthalf_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5,   -0.5,  0.5, -0.375, 0.5},  --  NodeBox1
		{-0.5, -0.375, -0.25, 0.5, -0.25,  0.5},  --  NodeBox2
		{-0.5, -0.25,  0,    0.5, -0.125, 0.5},  --  NodeBox3
		{-0.5, -0.125, 0.25, 0.5,  0,     0.5},  --  NodeBox4
	}
}

local slope_backhalf_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5,   -0.5,  0.5, 0.125, 0.5},  --  NodeBox1
		{-0.5, 0.125, -0.25, 0.5, 0.25,  0.5},  --  NodeBox2
		{-0.5, 0.25,  0,    0.5, 0.375, 0.5},  --  NodeBox3
		{-0.5, 0.375, 0.25, 0.5,  0.5,     0.5},  --  NodeBox4
	}
}

core.register_node('misc:node_1',{
	description = 'node_1',
	drawtype = 'nodebox',
	node_box = node,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node,
	selection_box = node,
	groups = group,
})

core.register_node('misc:node_2',{
	description = 'node_2',
	drawtype = 'nodebox',
	node_box = slope_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_3',{
	description = 'node_3',
	drawtype = 'nodebox',
	node_box = slope_cbox_long,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_4',{
	description = 'node_4',
	drawtype = 'nodebox',
	node_box = icorner_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_5',{
	description = 'node_5',
	drawtype = 'nodebox',
	node_box = ocorner_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_6',{
	description = 'node_6',
	drawtype = 'nodebox',
	node_box = short_pyr_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_7',{
	description = 'node_7',
	drawtype = 'nodebox',
	node_box = tall_pyr_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_8',{
	description = 'node_8',
	drawtype = 'nodebox',
	node_box = slope_fronthalf_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_9',{
	description = 'node_9',
	drawtype = 'nodebox',
	node_box = slope_backhalf_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_10',{
	description = 'node_10',
	drawtype = 'nodebox',
	node_box = node_stair,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_11',{
	description = 'node_11',
	drawtype = 'nodebox',
	node_box = node_slab,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_12',{
	description = 'node_12',
	drawtype = 'nodebox',
	node_box = node_inner_stair,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('misc:node_13',{
	description = 'node_13',
	drawtype = 'nodebox',
	node_box = node_outer_stair,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

--------------------------------------------------------------------------------------
core.register_node('misc:torch',{
	description = 'Torch',
	drawtype = 'mesh',
	mesh = "torch.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"torch.png"},
	light_source = 10,
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	selection_box = {
	type = "wallmounted",
	wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	groups = group,
})

------------------------------------------------------------------------------------
core.register_node("misc:pyramid_gate_lower", {
	description = "Original",
	tiles = {"ancient_brick.png"},
	drawtype = "mesh",
	mesh = "pyramid_gate_lower.obj",
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = group,
	climbable = true,
	})

core.register_node("misc:pyramid_gate_upper_og", {
	description = "Original",
	tiles = {"ancient_brick.png"},
	drawtype = "mesh",
	mesh = "pyramid_gate_upper.obj",
	groups = group,
	climbable = false,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	minetest.set_node(pos, {name = "misc:pyramid_gate_upper_alt",})
	end,
	})

core.register_node("misc:pyramid_gate_upper_alt", {
	description = "Alternate",
	tiles = {"transparent.png"},
	drawtype = "mesh",
	mesh = "pyramid_gate_upper.obj",
	groups = group,
	climbable = true,
	use_texture_alpha = "blend",
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	minetest.set_node(pos, {name = "misc:pyramid_gate_upper_og"})
	end,
	})
--------
core.register_node('misc:spaceship',{
    description = 'spaceship',
    drawtype = 'mesh',
    mesh = 'spaceship.obj',
    climbable = true,
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {"spaceship_tile.png"},
    use_texture_alpha = "blend",
    backface_culling = false,
    drop = "misc:spaceship",
    light_source = 4,
    collision_box = {
    type = "fixed",
    fixed = {0, 0, 0, 0, 0, 0},
    },
    groups = group,
    })

core.register_node('misc:spaceship_inside',{
    description = 'spaceship_inside',
    drawtype = 'mesh',
    mesh = 'spaceship_inside.obj',
    climbable = true,
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {"spaceship_tile.png"},
    collision_box = {
    type = "fixed",
    fixed = {0, 0, 0, 0, 0, 0},
    },
    groups = group,
    })
	
core.register_node("misc:spaceship_gate_right_og", {
	description = "Original",
	tiles = {"spaceship.png"},
	use_texture_alpha = "blend",
	backface_culling = false,
	drawtype = "mesh",
	mesh = "spaceship_gate_right.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = group,
	drop = "",
	collision_box = {
  	  type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, 2.500, 2.500},
	},
	selection_box = {
	type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, 2.500, 2.500},
	},
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	minetest.set_node(pos, {name = "misc:spaceship_gate_right_alt",})
	end,
	})

core.register_node("misc:spaceship_gate_right_alt", {
	description = "Alternate",
	tiles = {"transparent.png"},
	drawtype = "mesh",
	mesh = "spaceship_gate_right.obj",
	paramtype = "light",
	use_texture_alpha = "blend",
	backface_culling = false,
	groups = group,
	drop = "",
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	selection_box = {
	type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, 2.500, 2.500},
	},
	})
	
core.register_node('misc:spaceship_gate_left_og',{
	description = 'Original',
	drawtype = 'mesh',
	mesh = 'spaceship_gate_left.obj',
  	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"spaceship.png"},
	use_texture_alpha = "blend",
	drop = "",
	collision_box = {
	type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, 2.500, 2.500},
	},
  	  selection_box = {
	type = "fixed",
  	  fixed = {-0.5000, -0.5000, -0.5000, 0.5000, 2.500, 2.500},
	},
	groups = group,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	minetest.set_node(pos, {name = "misc:spaceship_gate_left_alt",})
	end,
})

core.register_node('misc:spaceship_gate_left_alt',{
	description = "Alternate",
	tiles = {"transparent.png"},
	drawtype = "mesh",
	mesh = "spaceship_gate_left.obj",
	paramtype = "light",
	use_texture_alpha = "blend",
	drop = "",
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	selection_box = {
	type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, 2.500, 2.500},
	},
	groups = group,
})
----------------------------------------------------

core.register_node('misc:light_source',{
	description = 'Light Source',
	inventory_image = "light.png",
	drawtype = 'nodebox',
	node_box = node,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"transparent.png"},
	use_texture_alpha = "blend",
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	selection_box = node,
	groups = group,
	light_source = 14,
})

core.register_node('misc:plane_light_source',{
	description = 'Plane Light Source',
	inventory_image = "light.png",
	drawtype = 'nodebox',
	node_box = node,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"transparent.png"},
	use_texture_alpha = "blend",
	collision_box = {
	type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, -0.5000, 0.5000},
	},
	selection_box = {
	type = "fixed",
	fixed = {-0.5000, -0.5000, -0.5000, 0.5000, -0.5000, 0.5000},
	},
	groups = group,
	light_source = 14,
})

-- Some properties have been removed as they are beyond
--  the scope of this chapter.
core.register_node("misc:water_source", {
    drawtype = "liquid",
    paramtype = "light",
    use_texture_alpha = "blend",
    inventory_image = core.inventorycube("water.png"),
    -- ^ this is required to stop the inventory image from being animated
    tiles = {"water.png"},
    walkable     = false, -- The player falls through
    pointable    = false, -- The player can't highlight it
    diggable     = true, -- The player can't dig it
    buildable_to = true,  -- Nodes can be replace this node
    climbable = true,
    alpha = 160,
    drowning = 1,
    liquid_range = 8,
    -- ^ how far
    post_effect_color = {a=64, r=100, g=100, b=200},
    -- ^ colour of screen when the player is submerged
})

core.register_node('misc:bone',{
	description = 'Bone',
	drawtype = 'mesh',
	mesh = "bone.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"bones.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2 ,crumbly = 1,falling_node = 1 },
})

core.register_node('misc:skull',{
	description = 'skull',
	drawtype = 'mesh',
	mesh = "skull.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"bones.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2,crumbly = 1,falling_node = 1 },
})

core.register_node('misc:ribs',{
	description = 'ribs',
	drawtype = 'mesh',
	mesh = "ribs.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"bones.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2,crumbly = 1,falling_node = 1 },
})

core.register_node('misc:sam_model',{
	description = 'sam',
	drawtype = 'mesh',
	mesh = "player_model.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"character.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2 ,crumbly = 1,falling_node = 1 },
})

core.register_node('misc:beast',{
	description = 'sam',
	drawtype = 'mesh',
	mesh = "beast_node_2.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"beast.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2 },
})

core.register_node('misc:body',{
	description = 'body',
	drawtype = 'mesh',
	mesh = "body.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"villager.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2,crumbly = 1,falling_node = 1 },
})

core.register_node('misc:dead_body',{
	description = 'dead body',
	drawtype = 'mesh',
	mesh = "dead_body.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"villager.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2,crumbly = 1,falling_node = 1 },
})

core.register_node('misc:hand',{
	description = 'hand',
	drawtype = 'mesh',
	mesh = "hand.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"villager.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2, crumbly = 1,falling_node = 1 },
})

core.register_node('misc:head',{
	description = 'head',
	drawtype = 'mesh',
	mesh = "head.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"villager.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2, crumbly = 1, falling_node = 1 },
})

core.register_node('misc:leg',{
	description = 'leg',
	drawtype = 'mesh',
	mesh = "leg.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"villager.png"},
	use_texture_alpha = "clip",
	climbable = true,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2, crumbly = 1,falling_node = 1 },
})

core.register_node('misc:bag',{
	description = 'Bag',
	drawtype = 'mesh',
	mesh = "bag.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"bag.png"},
	use_texture_alpha = "clip",
	climbable = f,
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2 ,crumbly = 3,},
})

minetest.register_node("misc:bag_empty", {
	description = "Bag",
	stack_max=10,
	drawtype = 'mesh',
	mesh = "bag.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"bag.png"},
	use_texture_alpha = "clip",
	collision_box = {
	type = "fixed",
	fixed = {0, 0, 0, 0, 0, 0},
	},
	groups = {oddly_breakable_by_hand = 2, crumbly = 3, },
	walkable=false,
allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local n=player:get_player_name()
		if n~=minetest.get_meta(pos):get_string("owner") and minetest.is_protected(pos,n) then
			return 0
		end
		return stack:get_count()
	end,
allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local n=player:get_player_name()
		if n~=minetest.get_meta(pos):get_string("owner") and minetest.is_protected(pos,n) then
			return 0
		end
		return stack:get_count()
	end,
allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local n=player:get_player_name()
		if n~=minetest.get_meta(pos):get_string("owner") and minetest.is_protected(pos,n) then
			return 0
		end
		return count
	end,
can_dig = function(pos, player)
		return minetest.get_meta(pos):get_inventory():is_empty("main")
	end,
after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta=minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("infotext", "Plastic bag")
		meta:get_inventory():set_size("main", 4)
		meta:set_string("formspec",
		"size[8,5]" ..
		"list[context;main;2,0;4,1;]" ..
		"list[current_player;main;0,1;8,4;]" ..
		"listring[current_player;main]" ..
		"listring[current_name;main]")
end,
on_use=function(itemstack, user, pointed_thing)
	local pos=user:get_pos()
	pos.y=pos.y+1.5
	local def=minetest.registered_nodes[minetest.get_node(pos).name]
	if def and def.drowning==0 then
		itemstack:take_item(1)
		user:get_inventory():add_item("main", "misc:bag")
	end
	return itemstack
end})

minetest.register_craftitem("misc:bag", {
	description = "bag maker",
	stack_max=10,
	inventory_image = "bag.png",
	groups={not_in_creative_inventory=1},
on_use=function(itemstack, user, pointed_thing)
	itemstack:take_item(1)
	user:get_inventory():add_item("main", "misc:bag_empty")
	user:set_breath(11)
	return itemstack
end})
-----------------------------------------
-- Define a namespace for the custom inventory API
local custom_inventory = {}

-- Function to initialize a custom inventory for a player
function custom_inventory.init(player, size)
    local player_name = player:get_player_name()
    player:get_inventory():set_size("custom_main", size)  -- Set the size of the custom inventory
    minetest.log("action", "Custom inventory initialized for player: " .. player_name)
end

-- Function to show the custom inventory formspec
function custom_inventory.show_formspec(player)
    local player_name = player:get_player_name()
    local formspec = "size[8,9]" ..
                     "label[0,0;Custom Inventory]" ..
                     "list[current_player;custom_main;0,1;8,4;]" ..
                     "list[current_player;main;0,5.85;8,1;]" ..
                     "listring[current_player;custom_main]" ..
                     "listring[current_player;main]"

    minetest.show_formspec(player_name, "custom_inventory:inventory", formspec)
end

-- Handle the formspec submission
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "custom_inventory:inventory" and fields.quit then
        -- Handle inventory close actions if needed
        minetest.log("action", "Custom inventory closed for player: " .. player:get_player_name())
    end
end)

-- Register a command to open the custom inventory (for testing purposes)
minetest.register_chatcommand("custom_inventory", {
    description = "Open your custom inventory",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player then
            custom_inventory.init(player, 32)  -- Initialize inventory with 32 slots
            custom_inventory.show_formspec(player)
        end
    end
})


-------------------
core.register_node('misc:glow_stone',{
    description = 'Ancient Glow Stone',
    drawtype = 'mesh',
    mesh = 'glow_stone.obj',
    paramtype = "light",
    tiles = {"glow_stone.png^glow.png"},
    drop = "misc:glow_stone",
    collision_box = {
    type = "fixed",
    fixed = {0, 0, 0, 0, 0, 0},
    },
    groups = {cracky = 2},
    light_source = 4,
    })
    

-- Map node to be placed on walls
minetest.register_node("misc:map", {
    description = "Wall Map",
    drawtype = "signlike",
    tiles = {"etb_map.png"},
    inventory_image = "map_icon.png",
    wield_image = "map_icon.png",
    visual_scale = 3.0,
    drop = "misc:map_item",
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    walkable = false,
    selection_box = { type = "wallmounted" },
    collision_box = {
        type = "fixed",
        fixed = {0, 0, 0, 0, 0, 0},
    },
    groups = {dig_immediate = 3, attached_node = 1},
    stack_max = 10,
})

-- Map item that opens formspec or places map
minetest.register_craftitem("misc:map_item", {
    description = "Map",
    inventory_image = "map_icon.png",
    stack_max = 10,

    -- Right-click on wall places map node
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        local under = pointed_thing.under
        local above = pointed_thing.above
        local dir = vector.subtract(under, above)
        local wallmounted = minetest.dir_to_wallmounted(dir)

        minetest.set_node(above, {name = "misc:map", param2 = wallmounted})
        itemstack:take_item()
        return itemstack
    end,

    -- Right-click in air opens fullscreen map formspec
    on_secondary_use = function(itemstack, user)
        local player_name = user:get_player_name()
        if player_name then
            minetest.show_formspec(player_name, "misc:map_preview",
                "formspec_version[4]"..
                "size[20,15]"..
                "no_prepend[]"..
                "bgcolor[#000000BB;true]"..
                "image[-0.5,-0.5;21,16;etb_map.png]"..
                "button_exit[8.5,14;3,1;exit;Close]"
            )
        end
        return itemstack
    end,
})


core.register_node('misc:chopper',{
    description = 'chopper',
    drawtype = 'mesh',
    mesh = 'chopper.obj',
    climbable = true,
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {"spaceship_tile.png"},
    use_texture_alpha = "blend",
    drop = "misc:chpper",
    light_source = 1,
    collision_box = {
    type = "fixed",
    fixed = {0, 0, 0, 0, 0, 0},
    },
    selection_box = {
    type = "fixed",
    fixed = {-0.5000, -0.5000, -0.5000, 0.5000, -0.5000, 0.5000},
    },
    groups = group,
    })

minetest.register_craftitem("misc:mission_log",{
	description = "Mission Log",
	stack_max=10,
	inventory_image = "mission_img.png",
on_use = function(itemstack, user, pointed_thing)
	local player_name = user:get_player_name()
        
	local mission_log_text = [[

1. Objective Alpha:
   Investigate Ancient Tree.

2. Objective Beta:
   Investigate the Area 1 for unknown Object.

3. Objective Gamma:
   Investigate the Area 2 for unknown Object.

4. Objective Delta:
   Kill the threat.

Stay vigilant, Commander.
        ]]

        minetest.show_formspec(player_name, "my_mod:mission_log", [[
            size[8,6]
            bgcolor[#080808BB;true]
            box[0,0;8,6;#000000DD]
            label[0.5,0.5;Mission Log]
            textarea[0.5,1;7.5,4;;]] .. minetest.formspec_escape(mission_log_text) .. [[;]
            button_exit[3,5.2;2,1;exit;Close]
        ]])
    end,
})


