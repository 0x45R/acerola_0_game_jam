extends BaseModule

@onready var audio_stream_player = $AudioStreamPlayer3D

func _finished():
	audio_stream_player.play()

func _ready():
	audio_stream_player.finished.connect(_finished)
