extends Sit

var first_time = true
@onready var audio_stream_player = $AudioStreamPlayer
@onready var center_container = $CanvasLayer/CenterContainer

func _input(event):
	if event is InputEventKey and event.pressed:
		audio_stream_player.stop()
		first_time = false
		var player = get_tree().get_root().get_child(0).get_node("Player")
		var fade_color_rect =  player.get_node("%FadeColorRect")
		var tween = create_tween()
		tween.tween_property(fade_color_rect,"modulate:a", 0, 0.5)
		tween.tween_property(center_container,"modulate:a", 0, 0.5)

func _ready(): 
	module.interaction_successful.connect(_interacted)
	var player = get_tree().get_root().get_child(0).get_node("Player")
	var fade_color_rect =  player.get_node("%FadeColorRect")
	center_container.modulate.a = 1
	fade_color_rect.modulate.a = 1
	await get_tree().create_timer(0.5).timeout
	_interacted(player)
	await get_tree().create_timer(0.5).timeout
	if first_time:
		audio_stream_player.play()
		await get_tree().create_timer(17).timeout
		first_time = false
	
	var tween = create_tween()
	tween.tween_property(fade_color_rect,"modulate:a", 0, 0.5)
	tween.tween_property(center_container,"modulate:a", 0, 0.5)
