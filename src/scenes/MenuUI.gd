extends CanvasLayer

@onready var day_label = %DayLabel
@onready var time_label = %TimeLabel
@onready var workers_label =%WorkersLabel

func _ready():
	var suffix = "th"
	match GameData.day:
		1:
			suffix = "st"
		2:
			suffix = "nd"
		3:
			suffix = "rd"
			
	day_label.text = "You survived %s%s day" % [GameData.day, suffix]
	if time_label:
		time_label.text = "TIME LEFT - %s" % [GameData.time_left]
	workers_label.text = "Overall kicked out %s lazy workers,
%s sleepy workers and 
%s naughty workers" % [GameData.lazy_workers_amount, GameData.sleepy_workers_amount, GameData.naughty_workers_amount]
