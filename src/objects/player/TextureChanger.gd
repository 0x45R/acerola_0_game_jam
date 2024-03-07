extends BaseModule

@export var materials: Array[BaseMaterial3D]
@export var root_node: Node3D
@export var current_texture: int: set = _set_texture

func _ready():
	current_texture = 1

func _set_texture(value):
	current_texture = value
	if not root_node:
		return
	var material = materials[current_texture]
	for child in root_node.get_children():
		if child is MeshInstance3D:
			child.set_surface_override_material(0,material)
