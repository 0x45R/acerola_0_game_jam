extends Control

@export var audio_bus_name: String
@onready var bus = AudioServer.get_bus_index(audio_bus_name)

@onready var audio_slider = $AudioSlider
@onready var value_label = $ValueLabel

func _value_changed(value):
	var percentage = value / audio_slider.max_value
	AudioServer.set_bus_volume_db(bus, linear_to_db(value))
	var volume = AudioServer.get_bus_volume_db(bus)
	var display = roundf(volume*10)/10
	if display < -20 or is_nan(display):
		display = "muted"
	value_label.text = "%s%s" % [display, "db" if not display is String else ""]

func _ready():
	_value_changed(db_to_linear(AudioServer.get_bus_volume_db(bus)))
	audio_slider.value_changed.connect(_value_changed)
