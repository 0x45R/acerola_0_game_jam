extends BaseModule

@onready var audio_stream_player = $AudioStreamPlayer3D

func _finished():
	audio_stream_player.play(randf_range(0, 15))

func _ready():
	_finished()
	await get_tree().process_frame
	audio_stream_player.finished.connect(_finished)
