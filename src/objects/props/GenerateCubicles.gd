@tool
extends Node3D

@export var row_name: String = "A": set = _set_row_name
@export var offset: Vector3: set = _set_offset
@export var cubicle: Resource: set = _set_cubicles
@export var amount: int: set = _set_amount

func _set_row_name(value):
	row_name = value
	_create_workstations()
func _set_offset(value):
	offset = value
	_create_workstations()
func _set_amount(value):
	amount = value
	_create_workstations()
func _set_cubicles(value):
	cubicle = value
	_create_workstations()

func _ready():
	_create_workstations()
	
func _create_workstations():
	if not Engine.is_editor_hint():
		return
	if get_child_count() >= amount:
		for child in get_children():
			child.free()

	for i in range(amount):
		var instance = cubicle.instantiate()
		var node_name = "%s%s" % [row_name, i+1]
		if not has_node(node_name):
			add_child(instance, true) 
			instance.name = node_name
			instance.position += offset*i
			instance.owner = get_tree().edited_scene_root
