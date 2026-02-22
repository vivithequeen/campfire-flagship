class_name ChartParser extends Node

@export var chart_file_path: String = "res://charts/Greg vs. The French.txt"
@export var chart_resolution: int = 192
@export var bpm: int = 120

func get_note_data() -> Array:
	var chart: String = FileAccess.get_file_as_string(chart_file_path)
	var note_data = []
	
	for line: String in chart.split("\n", false):
		var words: PackedStringArray = line.split(" ")
		note_data.insert(0, {
			"position": float(words[0])/chart_resolution / bpm*60,
			"column": int(words[3]),
		})
	return note_data
