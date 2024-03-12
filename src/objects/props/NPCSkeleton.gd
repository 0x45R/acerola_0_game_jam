extends BaseModule

@onready var left_ik = $LeftIK
@onready var right_ik = $RightIK
@onready var spine_ik = $SpineIK

func stop_all_ik():
	left_ik.stop()
	right_ik.stop()
	spine_ik.stop()

func _ready():
	await get_tree().process_frame

	
	var workstation = entity.get_parent().get_parent()
	if workstation.state == workstation.STATE.Sleeping:
		spine_ik.start(true)
		left_ik.start(true)
		right_ik.start(true)
		var movement_module = get_module_root().get_node("Movement")
		movement_module.state = movement_module.STATE.Sitting
