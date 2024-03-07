extends BaseModule
@onready var open_audio_stream_player: AudioStreamPlayer3D = $OpenAudioStreamPlayer3D
@onready var close_audio_stream_player: AudioStreamPlayer3D = $CloseAudioStreamPlayer3D

func _interacted(_player):
	var openable = module.get_child_with_type(module, [Openable])
	if openable.open:
		open_audio_stream_player.play()
	else:
		close_audio_stream_player.play()
		
func _ready():
	module.interaction_successful.connect(_interacted)
