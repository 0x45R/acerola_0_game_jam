extends BaseModule
@onready var open_audio_stream_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _interacted(_player):
	open_audio_stream_player.play()

		
func _ready():
	module.interaction_successful.connect(_interacted)
