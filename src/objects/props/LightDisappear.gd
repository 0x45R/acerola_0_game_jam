@tool
extends MeshInstance3D

func _ready():
	var parent_name = get_parent().name
	var number = int(parent_name.right(1))
	if number is int:
		visible = number % 2 == 0
	#print(f)
	#visible = f == 0.0
