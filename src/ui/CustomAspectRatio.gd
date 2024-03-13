@tool
extends AspectRatioContainer
class_name CustomAspectRatioContainer

@export var width: float = 360: set = _set_width
@export var height: float = 240: set = _set_height

func _ready():
	_update_aspect_ratio()

func _set_width(value):
	width = value
	_update_aspect_ratio()
	
func _set_height(value):
	height = value
	_update_aspect_ratio()
	
func _update_aspect_ratio():
	ratio = width/height
