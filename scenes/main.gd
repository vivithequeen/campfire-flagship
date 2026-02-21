extends Node3D


@export var lanes : Array[Path3D]




func _physics_process(delta: float) -> void:
	var manual_note;
	if(Input.is_action_just_pressed("1")):
		manual_note = 0;
	if(Input.is_action_just_pressed("2")):
		manual_note = 1;
	if(Input.is_action_just_pressed("3")):
		manual_note = 2;
	if(Input.is_action_just_pressed("4")):
		manual_note = 3;
	if(Input.is_action_just_pressed("5")):
		manual_note = 4;

	spawn_note(manual_note)

	
func spawn_note(note):
	if(note || note == 0):
		lanes[note].create_note()