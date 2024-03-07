extends BaseModule
@onready var audio_stream_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _interacted(_player):
	if not audio_stream_player.playing:
		audio_stream_player.play()
		
func _ready():
	module.interaction_failed.connect(_interacted)
