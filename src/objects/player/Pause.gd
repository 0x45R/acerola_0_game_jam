extends BaseModule
@onready var canvas_layer = $CanvasLayer
var mouse_control
var paused = false

func _ready():
	canvas_layer.visible = false

func _pause():
	canvas_layer.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().current_scene.get_node("Modules/Game/Timer").pause_timer()

func _unpause():
	canvas_layer.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().current_scene.get_node("Modules/Game/Timer").unpause_timer()


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		if paused:
			_pause()
		else:
			_unpause()
	
