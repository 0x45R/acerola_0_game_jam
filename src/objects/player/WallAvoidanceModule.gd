extends BaseModule

@onready var raycast = $RayCast3D
@export var camera: BaseModule
var distance_to_point = 0
var distance = 0
func _process(delta):
	var collider = raycast.get_collider()
	if collider:
		var point = raycast.get_collision_point()
		distance_to_point = global_position.distance_to(point)

		distance = -1 * clampf(distance_to_point, 0,0.15)
		camera.position_offset.z = distance
