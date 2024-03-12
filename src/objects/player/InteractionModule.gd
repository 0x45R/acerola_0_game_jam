extends BaseModule

@onready var raycast = $RayCast3D
@export var interaction_bar: TextureProgressBar
var current_time: float = 0

func _process(delta):	
	if get_module_root().get_node("Pause").paused:
		return
	raycast.force_raycast_update()
	var collider = raycast.get_collider()
	interaction_bar.value = 0
	interaction_bar.max_value = 1
	interaction_bar.visible = true
	if not collider:
		interaction_bar.visible = false
		current_time = 0
		return
	var interaction = collider.get_parent()
	if not (interaction is BaseModule):
		interaction_bar.visible = false
		current_time = 0
		return
	if  interaction.ignore:
		interaction_bar.visible = false
		current_time = 0
		return
	var prop = interaction.get_module_root()
	if interaction.interaction_time == 0:
		if Input.is_action_just_pressed("interact"):
			current_time = 0
			interaction.interact(entity)
	else:
		if Input.is_action_pressed("interact"):
			current_time+=delta
		else:
			current_time-=delta
		current_time = clampf(current_time, 0, interaction.interaction_time+1)
	interaction_bar.max_value = interaction.interaction_time
	interaction_bar.value = current_time
	if current_time > interaction.interaction_time:
		current_time = 0
		interaction.interact(entity)
