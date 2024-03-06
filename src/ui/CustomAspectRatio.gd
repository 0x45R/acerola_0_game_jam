@tool
extends AspectRatioContainer
class_name CustomAspectRatioContainer

@export var width: float = 640
@export var height: float = 480

func _process(delta):
	ratio = width/height
