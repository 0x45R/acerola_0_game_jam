extends BaseModule

@export var requirement: BaseRequirement

func _interacted(_player):
	if requirement:
		requirement.fulfill_requirement()

func _ready():
	module.interacted.connect(_interacted)
