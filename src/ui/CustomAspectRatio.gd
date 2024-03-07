@tool
extends AspectRatioContainer
class_name CustomAspectRatioContainer

@export var width: float = 360	
@export var height: float = 240

func _process(delta):
	ratio = width/height
