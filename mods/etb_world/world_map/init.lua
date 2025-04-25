local world_map_nodes = {}

function world_map_nodes.register_world_map_node(name, description, texture, mesh)

mesh = mesh or "default_cube.obj" 
texture = texture or "default.png"

core.register_node("world_map:" .. name, {
	description = description,
	drawtype = "mesh",
	--paramtype2 = "facedir",
	mesh = mesh,
	tiles = {texture},
	groups = {cracky = 3},
})
end

world_map_nodes.register_world_map_node("tree", "tree", "map.png", "tree.obj")

