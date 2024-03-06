extends BaseModule

@export var scene_path: String

func _interacted(_player):
	if not scene_path:
		return
	print("[DOOR] Trying to teleport player to %s" % [scene_path])
	get_tree().change_scene_to_file(scene_path)
	
func _ready():
	module.interaction_successful.connect(_interacted)
