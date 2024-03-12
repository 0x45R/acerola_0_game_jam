extends BaseModule
class_name Openable

@export var animation_player: AnimationPlayer
var open = false

func _interacted(_player):
	if animation_player.is_playing():
		return
	open = !open
	animation_player.current_animation = "open" if open else "closed"

func _ready():
	module.interaction_successful.connect(_interacted)
	if not animation_player:
		animation_player = get_module_root().get_parent().get_node("AnimationPlayer")
