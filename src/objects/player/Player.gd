extends CharacterBody3D

@export var remote_velocity: Vector3
@export var remote_direction: Vector3
@export var remote_input_vector: Vector2
@export var gravity_force: Vector3
@export var frozen: bool = false

func _physics_process(delta):
	if frozen:
		return
	var direction = remote_direction
	velocity = remote_velocity + direction + gravity_force
	move_and_slide()
	

