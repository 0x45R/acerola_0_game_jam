extends BaseModule

@export var horizontal_clamp: Vector2 = Vector2(-360,360)
@export var vertical_clamp: Vector2 = Vector2(-80,50)

var rotation_axis = Vector2(1,1)
const MOUSE_SENSITIVITY = 3

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		if get_module_root().get_node("Pause").paused:
			return
		var mouse_input = event.relative * -0.001 * MOUSE_SENSITIVITY
		entity.rotate_y(mouse_input.x*rotation_axis.x)
		module.rotate_x(mouse_input.y*rotation_axis.y)
		entity.rotation_degrees.y = clampf(entity.rotation_degrees.y, horizontal_clamp.x, horizontal_clamp.y)
		module.rotation_degrees.x = clampf(module.rotation_degrees.x, vertical_clamp.x, vertical_clamp.y)
