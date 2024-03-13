extends Node

@onready var audio_stream_player = $AudioStreamPlayer

var time_left = 10

func _play_voice():
	if not audio_stream_player.playing:
		audio_stream_player.play()
		time_left = randf_range(15,45)

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		_play_voice()
	
