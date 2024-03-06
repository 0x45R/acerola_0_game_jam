extends BaseModule
class_name Movement

enum STATE {
	Walking,
	Running,
	Falling,
	Sitting,
	Sleeping
}

var state = STATE.Walking
