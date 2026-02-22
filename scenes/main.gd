extends Node3D


@export var lanes : Array[Path3D]
@export var chart_parser : ChartParser
@export var music_player: AudioStreamPlayer
@export var wait_time : float = 1.0

var note_data : Array
var next_note_position: float
var next_note_column: int

var health = 5;

var hit_timer = 0;

var can_be_hit = true;

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
	$french.finished.connect(get_tree().change_scene_to_file.bind("res://noob/scenes/main_menu.tscn"))


func _physics_process(delta: float) -> void:
	if(health < 5):
		hit_timer+=delta;
		if(hit_timer > 1.4):
			health+=1;
			hit_timer = 0;
	if music_player.playing and music_player.get_playback_position() >= next_note_position:
		spawn_note(next_note_column)
		pop_next_note()
		
	# var manual_note;
	# if(Input.is_action_just_pressed("1")):
	# 	manual_note = 0;
	# if(Input.is_action_just_pressed("2")):
	# 	manual_note = 1;
	# if(Input.is_action_just_pressed("3")):
	# 	manual_note = 2;
	# if(Input.is_action_just_pressed("4")):
	# 	manual_note = 3;
	# if(Input.is_action_just_pressed("5")):
	# 	manual_note = 4;

	# spawn_note(manual_note)

	var tween = get_tree().create_tween();
	tween.tween_property($CanvasLayer/ProgressBar, "value", (20 * health), delta * 5);


func _on_area_3d_area_entered(_area: Area3D) -> void:
	if(!can_be_hit):
		return;
	health-=1;
	hit_timer = 0;
	can_be_hit = false;
	if(health == 0):
		get_tree().change_scene_to_file("res://noob/scenes/main_menu.tscn")
		return;
	flash_white()

	

func flash_white():
	# Get any mesh that uses the shared material
	var mesh: MeshInstance3D = $greg

	# Get the base material (shared)
	var base_mat: Material = mesh.material_overlay



	# Enable flash
	base_mat.set("shader_parameter/flash", 1.0)
	await get_tree().create_timer(0.1).timeout
	base_mat.set("shader_parameter/flash", 0.0)
	await get_tree().create_timer(0.1).timeout
	base_mat.set("shader_parameter/flash", 1.0)
	await get_tree().create_timer(0.1).timeout
	base_mat.set("shader_parameter/flash", 0.0)
	await get_tree().create_timer(0.1).timeout
	base_mat.set("shader_parameter/flash", 1.0)
	await get_tree().create_timer(0.1).timeout
	base_mat.set("shader_parameter/flash", 0.0)
	can_be_hit = true;


func _on_music_player_finished() -> void:
	$french.explode()
