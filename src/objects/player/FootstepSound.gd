extends BaseModule

@onready var apartment_audio_stream_player = $ApartmentAudioStreamPlayer3D
@onready var office_audio_stream_player = $OfficeAudioStreamPlayer3D

var playback_position: float = 0.0

func _physics_process(_delta):
	var movement_module = get_module_root().get_node("Movement")
	var audio_stream_player
	if get_tree().get_root().get_child(0).name == "Office":
		audio_stream_player = office_audio_stream_player
	else:
		audio_stream_player = apartment_audio_stream_player 
	if movement_module.state == movement_module.STATE.Walking:
		audio_stream_player.pitch_scale = 1.25
	if movement_module.state == movement_module.STATE.Running:
		audio_stream_player.pitch_scale = 1.75
	if entity.remote_input_vector != Vector2.ZERO:
		if not audio_stream_player.playing:
			audio_stream_player.play(playback_position)
	else:
		if audio_stream_player.playing:
			playback_position = audio_stream_player.get_playback_position()
			audio_stream_player.stop()
	if audio_stream_player.get_playback_position() > 5:
		audio_stream_player.seek(0)
