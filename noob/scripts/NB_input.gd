extends Node

@export var input_value = 0

func _process(delta: float) -> void:
	input_value = fmod((input_value + delta), 1)