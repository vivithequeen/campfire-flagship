extends HSlider

var audio_input_devices
@export var input_device: int = 0

func _ready() -> void:
	audio_input_devices = AudioServer.get_input_device_list()
	max_value = audio_input_devices.size() - 1
	value_changed.connect(slider_changed)

func slider_changed(p_value):
	Volume_calibrations.mics[input_device] = p_value


func _on_continue_button_pressed() -> void:
	pass # Replace with function body.
