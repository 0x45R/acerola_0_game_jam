extends BaseModule
@onready var canvas_layer = $CanvasLayer
var mouse_control
var paused = false

func _ready():
	canvas_layer.visible = false

func _pause():
	canvas_layer.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unpause():
	canvas_layer.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		if paused:
			_pause()
		else:
			_unpause()
	
