extends Node


var greg_lane : int = 1;


var lane_x = [-1.6,-0.8,0,0.8,1.6]


@export var greg_model : Node3D

func _physics_process(delta: float) -> void:
		
	var dir = int(Input.is_action_just_pressed("left")) - int(Input.is_action_just_pressed("right"))

	if(dir == -1):
		move_left()
	elif(dir == 1):
		move_right();
		
func move_right():
	if(greg_lane == 0):
		return;
	
	move_greg(greg_lane, greg_lane-1)
	greg_lane-=1;

func move_left():
	if(greg_lane == 4):
		return;
	
	move_greg(greg_lane, greg_lane+1)
	greg_lane+=1;

func move_greg(from, to):
	var tween = get_tree().create_tween()

	tween.tween_property(greg_model, "global_position:x", lane_x[to], 0.1) \
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
