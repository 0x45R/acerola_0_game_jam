extends BaseModule

@export var requirement: BaseRequirement

func check_requirements(_player = null):
	print(requirement.fulfilled, module.can_interact)
	module.can_interact = requirement.fulfilled

func _ready():
	check_requirements()
	module.interacted.connect(check_requirements)
