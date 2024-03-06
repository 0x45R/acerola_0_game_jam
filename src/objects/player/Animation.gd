extends BaseModule

@export var animation_tree: AnimationTree
var input_direction: Vector2
@onready var movement_module = get_module_root().get_node("Movement")

func _physics_process(delta):
	input_direction = lerp(input_direction, entity.remote_input_vector, delta*15)
	animation_tree["parameters/State/transition_request"] = movement_module.STATE.keys()[movement_module.state]
	animation_tree["parameters/Walking/blend_position"] = input_direction
	animation_tree["parameters/Running/blend_position"] = input_direction
