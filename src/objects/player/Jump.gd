extends BaseModule
@export var jump_velocity = 4 

func _physics_process(delta):
	if get_module_root().get_node("Pause").paused:
		return
	if Input.is_action_just_pressed("move_jump") and entity.is_on_floor():
		entity.remote_velocity.y = jump_velocity
	
