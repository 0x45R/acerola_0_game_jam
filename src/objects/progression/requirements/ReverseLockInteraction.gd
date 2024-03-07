extends BaseModule

@export var requirement: BaseRequirement

func check_requirements(_player = null):
	module.can_interact = not requirement.fulfilled

func _ready():
	check_requirements()
	module.interacted.connect(check_requirements)
