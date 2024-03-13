extends Button

@export var game_scene = "res://src/scenes/Office.tscn"

func _pressed():
	if is_inside_tree():
		GameData.day += 1
		get_tree().change_scene_to_file(game_scene)
	
func _ready():
	pressed.connect(_pressed)
