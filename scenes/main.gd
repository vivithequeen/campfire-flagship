extends Node3D


@export var lanes : Array[Path3D]
@export var chart_parser : ChartParser
@export var music_player: AudioStreamPlayer
@export var wait_time : float = 1.0

var note_data : Array
var next_note_position: float
var next_note_column: int


func pop_next_note() -> void:
	if note_data.size() == 0:
		next_note_position = INF
		return
	var next_note = note_data.pop_back()
	next_note_position = next_note["position"]
	next_note_column = next_note["column"]


func spawn_note(note):
	if(note || note == 0):
		lanes[note].create_note()


func _ready() -> void:
	note_data = chart_parser.get_note_data()
	pop_next_note()
	var timer = get_tree().create_timer(wait_time)
	timer.timeout.connect(music_player.play)


func _physics_process(_delta: float) -> void:
	if music_player.playing and music_player.get_playback_position() >= next_note_position:
		spawn_note(next_note_column)
		pop_next_note()
		
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
