extends Path3D



var node_instance = load("res://scenes/notes/note.tscn");

@export var active_notes : Array[PathFollow3D] = [];
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_note();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in active_notes:
		i.progress_ratio+=delta



func create_note():
	var i = node_instance.instantiate();

	add_child(i);
	active_notes.append(i);
	
