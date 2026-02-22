extends Node

@export var input_value = 0
@export var setting_max = false

var effect : AudioEffect
var recording
var timer: float = 0
var max_vol: float= 1
var max_vol_2: float= 1
@export var visualiser: Sprite2D
@export var visualiser_2: Sprite2D
@export var visualiser_3: Sprite2D
var audio_input_devices
@export var debug: bool = false

func _ready() -> void:
	var idx = AudioServer.get_bus_index("mic_1")
	effect = AudioServer.get_bus_effect(idx, 0)
	print(effect)
	effect.format = 0
	audio_input_devices = AudioServer.get_input_device_list()
	print(audio_input_devices)
	AudioServer.set_input_device(audio_input_devices[0])
	effect.set_recording_active(true)

func _process(delta: float) -> void:
	timer += delta
	if debug:
		visualiser.visible = true
		visualiser_2.visible = true
		visualiser_3.visible = true
	else:
		visualiser.visible = false
		visualiser_2.visible = false
		visualiser_3.visible = false
	var temp_recording = effect.get_recording()
	if temp_recording:
		var avg: float = 0
		var avg_2: float = 0
		var indexer: int = 0
		if Volume_calibrations.reset:
			Volume_calibrations.max_vol = [0,0]
		for i in temp_recording.data.slice(temp_recording.data.size() - 50000):
			indexer = (indexer + 1) % 2
			if indexer == 0:
				avg += abs(i)  
			else: 
				avg_2 += abs(i)
		if setting_max:
			if avg > Volume_calibrations.max_vol[0]: Volume_calibrations.max_vol[0] = avg 
			if avg_2 > Volume_calibrations.max_vol[1]: Volume_calibrations.max_vol[1] = avg_2
		var temp_1 = min(avg / Volume_calibrations.max_vol[0], 1)
		var temp_2 = min(avg_2 / Volume_calibrations.max_vol[1], 1)
		if debug: visualiser.global_position.x = temp_1 * 600
		if debug: visualiser_2.global_position.x = temp_2 * 600
		var temp_3 = clamp(
			(temp_1 - temp_2 - Volume_calibrations.difrance[0]) / max(
				(
					Volume_calibrations.difrance[1] - 
					Volume_calibrations.difrance[0]
				),
				0.0001
			), 0, 1)
		input_value = temp_3
		if debug: visualiser_3.global_position.x = temp_3 * 600
		if Volume_calibrations.callib_mode == -1:
			Volume_calibrations.difrance[0] = temp_1 - temp_2;
		elif Volume_calibrations.callib_mode == 1:
			Volume_calibrations.difrance[1] = temp_1 - temp_2;

		# print(avg, " ", max_vol, " ", avg_2, max_vol_2)
	if timer > 10:
		timer = 0
		effect.set_recording_active(false)
		effect.set_recording_active(true)
