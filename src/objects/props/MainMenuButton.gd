extends Button

@export var main_menu_scene = "res://src/scenes/main_menu.tscn"

func _pressed():
	if is_inside_tree():
		GameData.reset_data()
		get_tree().change_scene_to_file(main_menu_scene)
	
func _ready():
	pressed.connect(_pressed)
