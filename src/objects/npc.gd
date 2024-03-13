extends CharacterBody3D

@export var remote_velocity: Vector3
@export var remote_direction: Vector3
@export var remote_input_vector: Vector2
@export var gravity_force: Vector3
@export var frozen: bool = false

func _set_all_children_process(node = self, value = false):
	set_process(value)
	set_physics_process(value)
	for child in node.get_children():
		_set_all_children_process(child, value)

func _ready():
	_set_all_children_process(self, false)

func _physics_process(delta):
	if frozen:
		return
	var direction = remote_direction
	velocity = remote_velocity + direction + gravity_force
	if velocity:
		move_and_slide()
	

