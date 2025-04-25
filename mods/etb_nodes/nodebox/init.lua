local texture = {"transparent.png"}

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

core.register_node('nodebox:node_1',{
	description = 'node_1',
	drawtype = 'nodebox',
	node_box = node,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node,
	selection_box = node,
	groups = group,
})

core.register_node('nodebox:node_2',{
	description = 'node_2',
	drawtype = 'nodebox',
	node_box = slope_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('nodebox:node_3',{
	description = 'node_3',
	drawtype = 'nodebox',
	node_box = slope_cbox_long,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('nodebox:node_4',{
	description = 'node_4',
	drawtype = 'nodebox',
	node_box = icorner_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('nodebox:node_5',{
	description = 'node_5',
	drawtype = 'nodebox',
	node_box = ocorner_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('nodebox:node_6',{
	description = 'node_6',
	drawtype = 'nodebox',
	node_box = short_pyr_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('nodebox:node_7',{
	description = 'node_7',
	drawtype = 'nodebox',
	node_box = tall_pyr_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('nodebox:node_8',{
	description = 'node_8',
	drawtype = 'nodebox',
	node_box = slope_fronthalf_cbox,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('nodebox:node_9',{
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

core.register_node('nodebox:node_10',{
	description = 'node_10',
	drawtype = 'nodebox',
	node_box = node_stair,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('nodebox:node_11',{
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

core.register_node('nodebox:node_12',{
	description = 'node_12',
	drawtype = 'nodebox',
	node_box = node_inner_stair,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})

core.register_node('nodebox:node_13',{
	description = 'node_13',
	drawtype = 'nodebox',
	node_box = node_outer_stair,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = texture,
	use_texture_alpha = "clip",
	unlight_propagates = true,
	collision_box = node_box,
	selection_box = node_box,
	groups = group,
})
