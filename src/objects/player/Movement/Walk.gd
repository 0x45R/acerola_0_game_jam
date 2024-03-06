extends BaseModule

@export var walk_speed = 3.5

func _physics_process(delta):
	if (module.state == module.STATE.Running or module.state == module.STATE.Sitting or module.state == module.STATE.Sleeping):
		return
	module.state = module.STATE.Walking

	var input_vector = Input.get_vector("move_left","move_right","move_forward","move_backward").normalized() 
	var direction = Vector3(input_vector.x, 0, input_vector.y)
	entity.remote_input_vector = input_vector
	entity.remote_direction = entity.transform.basis * direction * walk_speed
