extends BaseModule
var time_left
@onready var day_label = %DayLabel
@onready var tick_timer = $TickTimer
@onready var timer_label = %TimerLabel
@onready var modifier_label = %ModifierLabel
@onready var animation_player = $CanvasLayer/CustomAspectRatioContainer/MarginContainer/VBoxContainer/AnimationPlayer

var paused = false

func unpause_timer():
	paused = false
	
func pause_timer():
	paused = true
	
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
	
	GameData.time_left =  "%s:%s" % [minutes, seconds]
	timer_label.text = "%s:%s" % [minutes, seconds]

func _timeout():
	print("[TIMER] No time left, game ending")
	module.end_game()

func _tick_timeout():
	_update_label()
	tick_timer.start()
	if paused:
		return
	time_left-=tick_timer.wait_time

	if time_left <= 0:
		_timeout()

func _ready():
	time_left = GameData.get_time()
	day_label.text = "DAY %s" % GameData.day
	_update_label()
	tick_timer.timeout.connect(_tick_timeout)
