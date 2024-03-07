extends Label

func _ready():
	var parent = get_node("../../..")
	if parent:
		text = parent.name

