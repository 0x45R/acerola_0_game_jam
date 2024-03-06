extends BaseModule

@onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	if not entity.is_on_floor():
		module.state = module.STATE.Falling
		entity.remote_velocity.y -= gravity * delta
		entity.remote_direction = lerp(entity.remote_direction,entity.remote_direction, delta*5)
