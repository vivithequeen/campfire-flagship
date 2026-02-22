extends Button

func _on_pressed() -> void:
	var temp = preload("res://scenes/main.tscn")
	var temp2 = temp.instantiate()
	$"../../../".add_child(temp2)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
