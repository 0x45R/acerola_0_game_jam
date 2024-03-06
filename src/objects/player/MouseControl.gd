extends BaseModule

var mouse_mode: int: set = _set_mouse_mode, get = _get_mouse_mode

func _set_mouse_mode(value):
	mouse_mode = value
	
func _get_mouse_mode():
	return mouse_mode

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
