extends Node

@export var input_value = 0

var effect : AudioEffect
var effect_2 : AudioEffect
var recording
var timer:float = 0
var max_vol: float= 1
var max_vol_2: float= 1
var input_device = 0
@export var visualiser: Sprite2D
@export var visualiser_2: Sprite2D
var audio_input_devices
var timer_2: float = 0

func _ready() -> void:
	var idx = AudioServer.get_bus_index("mic_1")
	effect = AudioServer.get_bus_effect(idx, 0)
	effect.format = 0
	audio_input_devices = AudioServer.get_input_device_list()
	print(audio_input_devices)
	AudioServer.set_input_device(audio_input_devices[0])
	effect.set_recording_active(true)
	# await get_tree().create_timer(1).timeout
	# for i in effect.get_recording().data:
	# 	if i != 0:
	# 		print(i)
	# effect.set_recording_active(false)

	# print(effect_2)

func _process(delta: float) -> void:
	timer += delta
	timer_2 += delta
	
	var temp_recording = effect.get_recording()
	if temp_recording:
		# if !effect.is_empty():?\
		var avg: float = 0
		var index = -1
		for i in temp_recording.data.slice(temp_recording.data.size() - 1000):
			index += 1
			# if index % 2 == 0:
			# 	continue
			avg += abs(i)
			# if i > 0:
			# 	print(i)
		if avg >  (max_vol if input_device == 0 else max_vol_2):
			if input_device == 0: 	max_vol = avg
			else: 					max_vol_2 = avg
		if input_device == 0: 	visualiser.global_position.x = avg / max_vol * 600
		else: 					visualiser_2.global_position.x = avg / max_vol_2 * 600
		print(avg, " ", input_device, " ", (max_vol if input_device == 0 else max_vol_2))
		if timer_2 > 0.2:
			timer_2 = 0
			input_device = (input_device + 1) % 2
			AudioServer.set_input_device(audio_input_devices[Volume_calibrations.mics[0] if input_device == 0 else Volume_calibrations.mics[1]])
	if timer > 1:
		timer = 0
		effect.set_recording_active(false)
		effect.set_recording_active(true)
