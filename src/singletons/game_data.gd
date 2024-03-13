extends Node
@export var splash_shown = false
@export var day = 0
@export var max_days = 14
@export var won = false
@export var time_left: String

func reset_data():
	lazy_workers_amount = 0
	sleepy_workers_amount = 0
	naughty_workers_amount = 0
	day = 0
	won = false

func _ready():
	print(get_time())

func get_time():
	return abs((day-(max_days-1))*(max_days-1))

func get_states():
	return {
		"Lazy" = clamp(day,1,9),
		"Sleeping" = clamp(day*3, 1, 16),
		"Naughty" = clamp(day*3, 1, 16)
	}

@export var lazy_workers_amount: int
@export var sleepy_workers_amount: int
@export var naughty_workers_amount: int

func neccessary(employee):
	lazy_workers_amount+=1
	pass
	#employees_fired[employee.name] = employee.state

func extra(employee):
	print(employee)
	if employee.state == employee.STATE.Sleeping:
		sleepy_workers_amount+=1
	if employee.state == employee.STATE.Naughty:
		naughty_workers_amount+=1
	#employees_fired[employee.name] = employee.state
