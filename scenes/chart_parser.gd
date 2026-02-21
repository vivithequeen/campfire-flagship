extends Node

const CHART_RESOLUTION: int = 192


func _ready() -> void:
	var chart: String = FileAccess.get_file_as_string("res://charts/Greg vs. The French.txt")
	var notes = []
	
	for line: String in chart.split("\n", false):
		var words: PackedStringArray = line.split(" ")
		var note = {
			"position": float(words[0]) / CHART_RESOLUTION,
			"column": int(words[3]),
		}
		notes.append(note)
	print(notes)
