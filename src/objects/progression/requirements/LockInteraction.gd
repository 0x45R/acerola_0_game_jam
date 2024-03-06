extends BaseModule

@export var requirement: BaseRequirement

func check_requirements(_player = null):
	var requirements_fulfilled = requirement.have_requirements_been_fulfilled()
	module.can_interact = requirements_fulfilled.result


func _ready():
	check_requirements()
	module.interacted.connect(check_requirements)
