extends BaseModule
class_name Movement

enum STATE {
	Walking,
	Running,
	Falling,
	Sitting,
	Sleeping
}

var state = STATE.Walking: set = _change_state

signal state_changed(state)

func _change_state(value: STATE):
	state = value
	state_changed.emit(value)
