extends BaseModule

signal forget()
signal ready_to_capture(npc)
signal prepare_to_capture(marker)

var current_npc

var door_marker

func _forget():
	current_npc.queue_free()
	current_npc = null
	entity.get_node("%RightIK").stop()
	entity.get_node("%LeftIK").stop()
	
func _process(delta):
	if current_npc:
		current_npc.global_transform = entity.get_node("CaptureMarker").global_transform
		var left_target = current_npc.get_node("%LeftIKTarget")
		var right_target = current_npc.get_node("%RightIKTarget")
		entity.get_node("%RightIK").start()
		entity.get_node("%LeftIK").start()
		entity.get_node("%RightIK").target = right_target.global_transform
		entity.get_node("%LeftIK").target = left_target.global_transform
		
func _captured(npc):
	var scene = get_tree().get_root().get_child(0)
	current_npc = npc
	var movement_module = get_module_root().get_node("Movement")
	movement_module.state = movement_module.STATE.Walking
	entity.frozen = false
	get_module_root().get_node("Movement/NavigationModule").target = scene.get_node("%DoorMarker")
	
	
func _prepare(marker):
	entity.frozen = true
	entity.global_transform = marker.global_transform
	var movement_module = get_module_root().get_node("Movement")
	var animation_player = get_module_root().get_node("%AnimationPlayer")
	movement_module.state = movement_module.STATE.Pulling

	#animation_player.seek(2.3, true)
	
	

func _ready():
	ready_to_capture.connect(_captured)
	prepare_to_capture.connect(_prepare)
	forget.connect(_forget)
