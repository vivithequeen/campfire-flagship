extends Path3D



var node_instance = load("res://scenes/notes/note.tscn");

@export var active_notes : Array[PathFollow3D] = [];
# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
# 	create_note();



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(active_notes.size()):
		print(active_notes[i].progress_ratio)
		active_notes[i].progress_ratio+=delta
		if(active_notes[i].progress_ratio > 0.95):
			
			active_notes[i].queue_free();
			active_notes.remove_at(i)
			break;
			

		



func create_note():
	var i = node_instance.instantiate();

	add_child(i);
	active_notes.append(i);
	
