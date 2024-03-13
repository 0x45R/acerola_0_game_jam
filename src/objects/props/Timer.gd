extends BaseModule

@export var time_left = 90
@onready var tick_timer = $TickTimer
@onready var timer_label = %TimerLabel
@onready var modifier_label = %ModifierLabel
@onready var animation_player = $CanvasLayer/CustomAspectRatioContainer/MarginContainer/VBoxContainer/AnimationPlayer

func modify_time(value):
	time_left += value
	var symbol = "+" if value > 0 else "-"
	modifier_label.text = "%s%s" % [symbol, abs(value)]
	animation_player.play("fade_in_out")

func _update_label():
	var time = floor(round(time_left*10)/10)
	
	var minutes = floor((time) / 60);
	var seconds = round(time - (minutes * 60));
	
	if minutes < 10:
		minutes = "0" + str(minutes)
	if seconds < 10:
		seconds = "0" + str(seconds)
		
	timer_label.text = "%s:%s" % [minutes, seconds]

func _timeout():
	print("[TIMER] No time left, game ending")
	module.end_game()

func _tick_timeout():
	_update_label()
	tick_timer.start()
	time_left-=tick_timer.wait_time

func _ready():
	_update_label()
	tick_timer.timeout.connect(_tick_timeout)
