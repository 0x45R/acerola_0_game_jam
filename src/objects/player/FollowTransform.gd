extends BaseModule

@export var node_to_follow: Node3D
@export var position_offset: Vector3
@export var weight: float = 1

func _physics_process(delta):
	var desired_position = node_to_follow.position+position_offset
	if weight <= 0:
		position = desired_position
	else:
		position = lerp(position, desired_position,delta*weight)
	
