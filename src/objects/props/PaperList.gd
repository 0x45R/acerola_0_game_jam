extends BaseModule

func _interacted(player):
	player.get_node("Modules/Inventory").pickup_item(self.get_node("../.."))
	module.ignore = true

func _ready():
	module.interaction_successful.connect(_interacted)
