extends Node

@export var input_value = 0

var effect : AudioEffect
var effect_2 : AudioEffect
var recording
var timer = 0
var max_vol = 1
@export var visualiser: Sprite2D

func _ready() -> void:
	var idx = AudioServer.get_bus_index("mic_1")
	var idx_2 = AudioServer.get_bus_index("mic_2")
	effect = AudioServer.get_bus_effect(idx, 0)
	effect.format = 0

	effect_2 = AudioServer.get_bus_effect(idx_2, 0)
	effect.set_recording_active(true)
	# await get_tree().create_timer(1).timeout
	# for i in effect.get_recording().data:
	# 	if i != 0:
	# 		print(i)
	# effect.set_recording_active(false)

	# print(effect_2)

func _process(delta: float) -> void:
	timer += delta
	if timer > 0.1:
		timer = 0
		var temp_recording = effect.get_recording()
		if temp_recording:
			# if !effect.is_empty():?\
			var avg = 0
			var index = -1
			for i in temp_recording.data:
				index += 1
				# if index % 2 == 0:
				# 	continue
				avg += abs(i)
				# if i > 0:
				# 	print(i)
			if avg > max_vol:
				max_vol = avg
			visualiser.global_position.x = float(avg) / float(max_vol) * float(1000)
			print(avg," ", max_vol, " ", avg / max_vol)
			effect.set_recording_active(false)
			effect.set_recording_active(true)
