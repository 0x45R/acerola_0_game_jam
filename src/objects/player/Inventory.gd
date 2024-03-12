extends BaseModule

@onready var socket: Node3D = $ChestAttachement/Socket
@export var right_ik: SkeletonIK3D
@export var left_ik: SkeletonIK3D

var current_item

func pickup_item(item):
	if not current_item:
		item.reparent(socket, false)
		item.position = Vector3.ZERO
		current_item = item
		right_ik.start()
		left_ik.start()

func _process(delta):
	if current_item:
		var right_ik_target = current_item.get_node("RightIK")
		var left_ik_target = current_item.get_node("LeftIK")
		
		right_ik.target = right_ik_target.global_transform
		left_ik.target = left_ik_target.global_transform
		
		
func drop_item():
	if current_item:
		current_item = null
		right_ik.stop()
		left_ik.stop()
