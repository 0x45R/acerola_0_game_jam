extends BaseModule
class_name BaseRequirement

@export var fulfilled: bool = false
@export var requirements: Array[BaseRequirement]

@export var description: String
@export var failed_message: String

func change_description(value):
	description = value
	module.description_changed(self)

func have_requirements_been_fulfilled() -> Dictionary:
	for requirement in requirements:
		if not requirement.fulfilled:
			return {"result": false, "requirement": requirement}
	return {"result": true}

func fulfill_requirement() -> void:
	if not fulfilled:
		var requirements_fulfilled = have_requirements_been_fulfilled()
		if not requirements_fulfilled.result:
			module.requirement_failed(requirements_fulfilled.requirement)
			print("[REQUIREMENT] Not all requirements have been fulfilled \"%s\"" % [name])
			return
		fulfilled = true
		module.requirement_completed(self)
