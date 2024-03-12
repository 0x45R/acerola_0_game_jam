extends BaseModule

var npc
var animation_player
@onready var stand_marker = $StandMarker

func _ready():
	entity = get_module_root().get_parent()
	await get_tree().create_timer(0.1).timeout
	module.can_interact = entity.state == entity.STATE.Sleeping or entity.state == entity.STATE.Lazy or entity.state == entity.STATE.Naughty #entity.sleeping or entity.naughty
	module.interaction_successful.connect(_success)
	module.interaction_failed.connect(_failed)
	npc = entity.get_node("%NPC")
	animation_player = entity.get_node("AnimationPlayer")
	
func _failed(_player):
	print("FIRING FAILED")

func _success(_player):
	var scene = get_tree().get_root().get_child(0)
	npc.get_node("%GeneralSkeleton").stop_all_ik()
	module.ignore = true
	
	var movement_module = npc.get_node("Modules/Movement")
	
	animation_player.play("fired")
	movement_module.state = movement_module.STATE.Typing

	await animation_player.animation_finished
	
	var stand_marker = entity.get_node("StandMarker")
	npc.global_transform = stand_marker.global_transform
	
	
	movement_module.state = movement_module.STATE.Walking

	npc.reparent(scene, true)
	npc.set_physics_process(true)
	npc.get_node("Modules/Movement/NavigationModule").start_navigation()


	
	#general_skeleton.set_bone_pose_position(0, Vector3(0,0,0))
	#general_skeleton.reset_bone_pose(0)
	#general_skeleton.set_bone_pose_rotation(0, Quaternion(0,0,0,0).normalized())

	#print("SUCCESS")


# WHEN NOT GOOD THEN TIME LOSS
