extends Node3D

@export var game_won_scene = "res://src/scenes/game_won.tscn"
@export var game_lost_scene = "res://src/scenes/game_lost.tscn"

func _ready():
	var scene
	print("Checking if won, %s" % ["Won" if GameData.won else "Not won"])
	if GameData.won:
		scene = game_won_scene
	else:
		scene = game_lost_scene
	await get_tree().process_frame
	print(scene)
	if is_inside_tree():
		get_tree().change_scene_to_file(scene)
