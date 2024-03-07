extends Sit

func _ready():
	module.interaction_successful.connect(_interacted)
	var player = get_tree().get_root().get_child(0).get_node("Player")
	#player.get_node("%FadeShaderContainer").material["shader_parameter/alpha"] = 255
	var fade_color_rect =  player.get_node("%FadeColorRect")
	fade_color_rect.modulate.a = 1
	await get_tree().create_timer(0.5).timeout
	_interacted(player)
	await get_tree().create_timer(0.5).timeout
	var tween = create_tween()
	tween.tween_property(fade_color_rect,"modulate:a", 0, 0.5)
