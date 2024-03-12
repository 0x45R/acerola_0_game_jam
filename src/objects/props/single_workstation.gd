extends BaseModule
@export var state: STATE = STATE.Lazy

enum STATE {
	Lazy=0,
	Excel=1,
	Sleeping=2,
	Naughty=3
}

func _ready():
	state = STATE.Excel
	var game = get_tree().get_root().get_child(0).get_node("Modules/Game")
	state = game.get_possible_state()
	if state == STATE.Lazy:
		game.add_workstation_to_list(name, state)
	#
	#game.add_workstation(name, state)
