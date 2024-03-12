extends BaseModule

var employee_list_entry = preload("res://src/objects/props/employee_list_entry.tscn")

@onready var efficency_list = $EfficencyList
@onready var employees_container = %EmployeesContainer

@export var workplace_laziness = 0
@export var workstations_amount = 180
@export var workstations: Dictionary

signal station_added(key, station)

func _all_workstations_ready():
	print("All workstations ready")
	for child in employees_container.get_children():
		child.queue_free()
	for key in workstations:
		var workstation = workstations[key]
		if workstation == STATE.Lazy:#.state == workstation.STATE.Lazy:
			var instance = employee_list_entry.instantiate()
			instance.get_node("%Code").text = key

			var employee_name = employee_names.pick_random()	
			instance.get_node("%Description").text = "%s\n%s efficency" % [employee_name, str(randi_range(0,49)) + "%"]
			employees_container.add_child(instance)
	
func add_workstation_to_list(key, workstation):
	if not key in workstations:
		workstations[key] = workstation

enum STATE {
	Lazy=0,
	Excel=1,
	Sleeping=2,
	Naughty=3
}

@export var possible_states = {
	"Lazy" = 9,
	"Sleeping" = 16,
	"Naughty" = 16
}

var index = 0

var states = []

func get_possible_state():
	index+=1
	if states.size() == 0:
		return STATE.Excel
	return states[index-1]

signal states_ready

func populate_states():
	for i in range(workstations_amount):
		for key in possible_states: 
			var item = possible_states[key]
			if item == 0:
				pass
			else:
				possible_states[key] = item- 1
				states.append(STATE[key])
	if states.size() <= workstations_amount:
		var diff = workstations_amount-states.size()
		for i in range(diff):
			states.append(STATE.Excel)
			
	states.shuffle()
	states_ready.emit()
	
var employee_names
	
func _ready():
	var file = FileAccess.open("res://src/data/names.txt", FileAccess.READ)
	employee_names = Array(file.get_as_text().split("\n"))

	populate_states()
	#await states_ready
	await get_tree().create_timer(1).timeout
	_all_workstations_ready()
