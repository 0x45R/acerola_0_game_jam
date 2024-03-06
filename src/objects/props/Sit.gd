extends BaseModule
class_name Sit
@export var horizontal_clamp: Vector2
@onready var sitting_marker: Marker3D = $SittingMarker
@onready var standing_marker: Marker3D = $StandingMarker
@export var state: Movement.STATE = Movement.STATE.Sitting
@export var custom_camera_offset: Vector3 = Vector3(0,-0.4,-0.15)
var sitting = false

func _interacted(player):
	sitting = !sitting
	var modules = player.get_node("Modules")
	var movement_module = modules.get_node("Movement")
	var camera = modules.get_node("Camera")
	var camera_rotation = camera.get_node("CameraRotation")
	if sitting:
		movement_module.state = state
		player.global_transform = sitting_marker.global_transform
		player.frozen = true
		camera.position_offset = custom_camera_offset
		if horizontal_clamp:
			camera_rotation.horizontal_clamp = horizontal_clamp 
		
	else:
		movement_module.state = movement_module.STATE.Walking
		player.frozen = false
		player.global_transform = standing_marker.global_transform
		camera.position_offset = Vector3(0,-0.4,-0.15)
		camera_rotation.horizontal_clamp = Vector2(-360,360)

func _ready():
	module.interacted.connect(_interacted)
