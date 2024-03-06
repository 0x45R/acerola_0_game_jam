extends BaseModule

@export var requirement: BaseRequirement

func _interacted(_player):
	requirement.fulfill_requirement()

func _ready():
	module.interacted.connect(_interacted)
