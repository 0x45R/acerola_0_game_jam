extends BaseModule
@export var ignore: bool = false
@export var interaction_time: float = 0
@export var can_interact: bool = true
signal interacted(player)
signal interaction_successful(player)
signal interaction_failed(player)

func interact(player):
	interacted.emit(player)
	if can_interact:
		interaction_successful.emit(player)
	else:
		interaction_failed.emit(player)
