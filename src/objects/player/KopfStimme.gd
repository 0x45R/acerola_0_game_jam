extends Node3D

@onready var audio_stream_player = $AudioStreamPlayer

var time_left = 25

func _play_voice():
	if not audio_stream_player.playing:
		audio_stream_player.play()
		time_left = randf_range(60,120)

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		_play_voice()
	
