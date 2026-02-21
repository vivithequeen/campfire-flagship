extends Node

@export var input_value = 0
@export var setting_max = false

var effect : AudioEffect
var recording
var timer:float = 0
var max_vol: float= 1
var max_vol_2: float= 1
@export var visualiser: Sprite2D
@export var visualiser_2: Sprite2D
var audio_input_devices

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

	var temp_recording = effect.get_recording()
	if temp_recording:
		var avg: float = 0
		var avg_2: float = 0
		var indexer: int = 0
		
		for i in temp_recording.data.slice(temp_recording.data.size() - 10000):
			indexer = (indexer + 1) % 2
			if Volume_calibrations.calibrating_ambience:
				if indexer == 0:
					if i > Volume_calibrations.noise_gate[0]: 
						Volume_calibrations.noise_gate[0] = i
				else:
					if i > Volume_calibrations.noise_gate[1]: 
						Volume_calibrations.noise_gate[1] = i
				
			if indexer == 0: 
				if i < Volume_calibrations.noise_gate[0]: continue
				avg += abs(i)  
			else: 
				if i < Volume_calibrations.noise_gate[1]: continue
				avg_2 += abs(i)
		if setting_max:
			if avg > Volume_calibrations.max_vol[0]: Volume_calibrations.max_vol[0] = avg 
			if avg_2 > Volume_calibrations.max_vol[1]: Volume_calibrations.max_vol[1] = avg_2
		visualiser.global_position.x = min(avg / Volume_calibrations.max_vol[0], 1) * 600
		visualiser_2.global_position.x = min(avg_2 / Volume_calibrations.max_vol[1], 1) * 600

		# print(avg, " ", max_vol, " ", avg_2, max_vol_2)
	if timer > 1:
		timer = 0
		effect.set_recording_active(false)
		effect.set_recording_active(true)
