extends Node3D
class_name BaseModule

@onready var module: BaseModule = get_module()
@onready var entity: Node3D = get_entity()

func _check_if_visible():
	self.set_process(visible)
	self.set_physics_process(visible)
	if not visible:
		queue_free()

func _ready():
	_check_if_visible()
	visibility_changed.connect(_check_if_visible)

func get_child_with_type(node = self, types = []):
	for child in node.get_children():
		for type in types:
			if is_instance_of(child, type):
				return child

func get_entity(node = self):
	return find_parent_of_type(node, [CharacterBody3D])

func get_module_root(node = self): 
	return find_parent_of_type(node, [RootModule])

func get_module(node = self):
	return find_parent_of_type(node, [BaseModule])
	
# Function to get player from any module
func find_parent_of_type(node = self, types = []):
	while true:
		var parent = node.get_parent()
		if not parent:
			return
		for type in types:
			if is_instance_of(parent, type):
				return parent
		node = parent

