extends AudioStreamPlayer
var playback # Will hold the AudioStreamGeneratorPlayback.
@onready var sample_hz = stream.mix_rate
var pulse_hz = 60.0 # The frequency of the sound wave.

func _ready():
	play()
	playback = get_stream_playback()
	fill_buffer()
	
func _process(delta):
	if get_playback_position() >= stream.buffer_length:
		seek(0)
		playback = get_stream_playback()
		fill_buffer()

func fill_buffer():
	var phase = 1.0
	var increment = pulse_hz / sample_hz
	var frames_available = playback.get_frames_available()

	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * (randf()*0.05 + sin(phase * TAU)))
		phase = fmod(phase + increment, 1.0)
