extends Sit

func _ready():
	module.interacted.connect(_interacted)
	await get_tree().create_timer(0.5).timeout
	var player = get_tree().get_root().get_child(0).get_node("Player")
	_interacted(player)
