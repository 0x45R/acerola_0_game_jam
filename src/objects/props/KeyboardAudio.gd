extends BaseModule

@onready var audio_stream_player = $AudioStreamPlayer3D

func _finished():
	audio_stream_player.play(randf_range(0, 15))

func _ready():
	await get_tree().process_frame
	var workstation = get_module_root().get_parent()
	if not workstation.state == workstation.STATE.Sleeping:
		audio_stream_player.finished.connect(_finished)
