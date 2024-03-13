extends Node

var node = preload("res://src/singletons/audio_manager.tscn")
func _ready():
	if node.can_instantiate():
		var instance = node.instantiate()
		add_child(instance)
