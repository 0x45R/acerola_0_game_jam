extends BaseModule

var employee_list_entry = preload("res://src/objects/props/employee_list_entry.tscn")

@onready var efficency_list = $EfficencyList
@onready var employees_container = %EmployeesContainer

@export var score = 0

@export var main_requirement: BaseRequirement

@export var workstations_amount = 180
@export var workstations: Dictionary
@export var erased_workstations: Array

signal station_added(key, station)
signal employee_fired(employee)

func employee_failed():
	get_node("Timer").modify_time(-6)
	
func end_game():
	print("[GAME] Game ended, counting score")
	GameData.won = false
	if is_inside_tree():
		get_tree().change_scene_to_file("res://src/scenes/game_over.tscn")

func _delete_from_list(key):
	for child in  employees_container.get_children():
		if child.name == key:
			erased_workstations.append(key) 
			var tween = get_tree().create_tween()
			var strikethrough = child.get_node("%StrikeThrough")
			tween.tween_property(strikethrough, "value", 100, 0.3)
			
	if erased_workstations.size() == workstations.keys().size():
		main_requirement.fulfill_requirement()
		GameData.won = true


		
		
func _employee_fired(employee):
	if employee.name in workstations.keys():
		GameData.neccessary(employee)
		# NECCESSARY
		_delete_from_list(employee.name)
		get_node("Timer").modify_time(6)
	else:
		GameData.extra(employee)
		# EXTRA
		get_node("Timer").modify_time(3)
		
func _update_list():
	for child in employees_container.get_children():
		child.queue_free()
	for key in workstations:
		var workstation = workstations[key]
		if workstation == STATE.Lazy:#.state == workstation.STATE.Lazy:
			var instance = employee_list_entry.instantiate()
			instance.name = key
			instance.get_node("%Code").text = key

			var employee_name = employee_names.pick_random()	
			instance.get_node("%Description").text = "%s\n%s efficency" % [employee_name, str(randi_range(0,49)) + "%"]
			employees_container.add_child(instance)
			
func _all_workstations_ready():
	print("All workstations ready")
	_update_list()
	
func add_workstation_to_list(key, workstation):
	if not key in workstations:
		workstations[key] = workstation

enum STATE {
	Lazy=0,
	Excel=1,
	Sleeping=2,
	Naughty=3
}

var possible_states = {
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
	GameData.won = false
	possible_states = GameData.get_states()
	
	# Just a random list of names, idk where i got it from
	# that's just a detail, the game is so low res that you won't be able to read anything, and you'll struggle with reading the workstation code alone. ty
	# ANY CONNECTION TO REAL PEOPLE IS RANDOM AND NOT INTEDED PLEASE DO NOT SUE ME
	var employee_names_raw = "Amelia Rosewater
Benjamin Wrightstone
Clara Nightingale
Diego Ramirez-Flores
Evelyn Dubois
Finnley Tanaka
Gabriela Hernandez
Henry Lawson
Isabella Kapoor
Jacob Moreau
Kimberly Young
Liam Petrov
Maya Diaz
Noah Watanabe
Olivia Chen
Patrick Murphy
Quinn Davies
Riley Garcia
Sophia Benítez
Thomas Nguyen
Ruppert Puwaski
Ava Durand
Benjamin Fischer
Chloe Jackson
David Kim
Emily Leclerc
Ethan Miller
Fiona Martinez
Gabriel Oliveira
Hannah Patel
Isaac Robinson
Isabella Sanchez
Jacob Thomas
Jasmine Walker
Julian Yang
Katherine Young
Liam Zhang
Lily Fernandez
Matthew Cohen
Mia Lee
Noah Lopez
Olivia Hernandez
Patrick Patel
Penelope Dubois
Quinn Takahashi
Riley Nguyen
Sophia Garcia
Thomas Oliveira
Ava Khan
Benjamin Durand
Chloe Miller
"
	
	# I couldn't get the names to work flawlessly. so i just embed them in code
	#var file = FileAccess.open("res://src/data/names.txt", FileAccess.READ)
	
	employee_names = Array(employee_names_raw.split("\n"))#Array(file.get_as_text().split("\n"))
	employee_fired.connect(_employee_fired)
	populate_states()
	#await states_ready
	await get_tree().create_timer(1).timeout
	_all_workstations_ready()
