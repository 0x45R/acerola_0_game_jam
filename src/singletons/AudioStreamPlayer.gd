extends AudioStreamPlayer

func _finished():
	play()

func _ready():
	finished.connect(_finished)
