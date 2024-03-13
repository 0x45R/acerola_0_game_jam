extends ColorRect

@export var one_shot = false
@export var wait_time = 0.5

func _ready():
	if GameData.splash_shown and one_shot: 
		modulate = Color(255,255,255,0)
		return
	modulate = Color(255,255,255,1)
	await get_tree().create_timer(wait_time).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.5)
	if one_shot:
		GameData.splash_shown = true

