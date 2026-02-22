extends Button

func _on_pressed() -> void:
	var temp = preload("res://scenes/main.tscn")
	var temp2 = temp.instantiate()
	$"../../../".add_child(temp2)
	$"../../".queue_free()
	temp2.get_node("greg_logic").nb_input = $"../../../Input"
	$"../../../Input".debug = false
