-- API for registering village nodes with custom meshes and textures
local village_nodes = {}

-- Helper function to register a village node with mesh and texture
function village_nodes.register_village_node(name, description, texture, mesh)

	mesh = mesh or "default_cube.obj"  -- Default mesh (cube)
	texture = texture or "default.png"  -- Default texture (plain)

core.register_node("village:" .. name, {
	description = description,
	drawtype = "mesh",
	paramtype2 = "facedir",
	--light_source = , 
	mesh = mesh,
	tiles = {texture},
	groups = {cracky = 3},
	sounds = default.node_sound_wood_defaults(),
	})
end

village_nodes.register_village_node("beast_head_totem", "Beast Head Totem", "beast_head_totem.png", "beast_head_totem.obj")
village_nodes.register_village_node("bed", "Bed", "bed.png", "bed.obj")
village_nodes.register_village_node("candle", "Candle", "candle.png", "candle.obj")
village_nodes.register_village_node("chair", "Chair", "chair.png", "chair.obj")

village_nodes.register_village_node("hut_1", "Hut_1", "hut.png", "hut_1.obj")
village_nodes.register_village_node("hut_2", "Hut_2", "hut.png", "hut_2.obj")
village_nodes.register_village_node("hut_3", "Hut_3", "hut.png", "hut_3.obj")

village_nodes.register_village_node("hut_roof_1", "Hut Roof 1", "hut_roof.png", "hut_roof_1.obj")
village_nodes.register_village_node("hut_roof_2", "Hut Roof 2", "hut_roof.png", "hut_roof_2.obj")
village_nodes.register_village_node("hut_roof_3", "Hut Roof 3", "hut_roof.png", "hut_roof_3.obj")

village_nodes.register_village_node("pot", "Pot", "pot.png", "pot.obj")
village_nodes.register_village_node("radio", "Radio", "radio.png", "radio.obj")
village_nodes.register_village_node("sofa", "Sofa", "sofa.png", "sofa.obj")
village_nodes.register_village_node("table", "Table", "sofa.png", "table.obj")
village_nodes.register_village_node("village_torch", "Village Torch", "village_torch.png", "village_torch.obj")


