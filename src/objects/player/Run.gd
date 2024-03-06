extends BaseModule

@export var run_speed = 7

func _physics_process(delta):
	if Input.is_action_pressed("move_run"):
		module.state = module.STATE.Running
		var input_vector = Input.get_vector("move_left","move_right","move_forward","move_backward").normalized() 
		var direction = Vector3(input_vector.x, 0, input_vector.y)
		entity.remote_input_vector = input_vector
		entity.remote_direction = lerp(entity.remote_direction, entity.transform.basis * direction * run_speed, delta*10)
	else:
		module.state = module.STATE.Walking
