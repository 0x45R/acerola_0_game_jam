extends BaseModule
@export var requirement: BaseRequirement
@export var animation_player: AnimationPlayer
var printed = false

func _interacted(_player):
	if printed:
		return
	if animation_player.is_playing():
		return
	printed = true
	module.ignore = true
	animation_player.current_animation = "printing"
	requirement.change_description("Wait...")
	await animation_player.animation_finished
	requirement.change_description("Pickup the list")
	get_module_root().get_parent().get_node("PaperList").get_node("InteractWithProp").ignore = false
	
func _ready():
	module.interaction_successful.connect(_interacted)
	if not animation_player:
		animation_player = get_module_root().get_parent().get_node("AnimationPlayer")
