extends BaseModule
class_name ProgressionManager

const FAILED_MESSAGE_FADE_TIME = 2

@onready var requirement_label = %CurrentRequirement
@onready var failed_label = %RequirementFailed

signal new_requirement(requirement)
signal failed_requirement(requirement)


func _ready():
	_update_label()
	new_requirement.connect(_update_label)
	new_requirement.connect(_clear_failed_label)
	failed_requirement.connect(_update_failed_label)
	
func _clear_failed_label(_requirement = null):
	_update_failed_label()
	
func _update_failed_label(requirement = null):


	if (requirement != null):
		if failed_label.modulate.a > 0:
			failed_label.modulate.a = 0
			failed_label.text = requirement.failed_message
			var tween = create_tween()
			tween.tween_property(failed_label, "modulate:a", 1, 0.2)
			await get_tree().create_timer(FAILED_MESSAGE_FADE_TIME).timeout
			_clear_failed_label()
	else:
		var tween = create_tween()
		failed_label.modulate.a = 1
		tween.tween_property(failed_label, "modulate:a", 0, 0.2)
		await get_tree().create_timer(0.2).timeout
		failed_label.text = ''
		
func _update_label(_requirement = null):
	requirement_label.text = ''
	for child in get_children():
		if child is BaseRequirement:
			if not child.fulfilled:
				requirement_label.text += child.description + "\n"

func description_changed(requirement):
	_update_label()

func requirement_failed(requirement):
	print("[PROGRESS] Requirement failed \"%s\"" % [requirement.name])
	failed_requirement.emit(requirement)

func complete_requirement(path):
	var requirement = get_node(path)
	print("[PROGRESS] Requirement fullfiled \"%s\"" % [requirement.name])
	new_requirement.emit(requirement)

func requirement_completed(requirement):
	print("[PROGRESS] Requirement fullfiled \"%s\"" % [requirement.name])
	new_requirement.emit(requirement)
