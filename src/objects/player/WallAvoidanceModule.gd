extends BaseModule

@onready var raycast = $RayCast3D
@export var camera: BaseModule

func _process(delta):
	var collider = raycast.get_collider()
	if collider:
		var point = raycast.get_collision_point()
		var distance = global_position.distance_to(point)
		distance = -1 * clampf(distance, 0,0.15)
		camera.position_offset.z = distance
