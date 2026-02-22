extends Button

@export var reset = false
@export var volume_calib = false
@export var left = false
@export var labels : Label
@export var disability = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if volume_calib:
		pressed.connect(calib_s)
	if reset:
		pressed.connect(resetium)
	if disability:
		toggled.connect(get_disabled)

func resetium():
	Volume_calibrations.max_vol = [0,0]

func calib_s():
	if Volume_calibrations.callib_mode == 0:
		Volume_calibrations.callib_mode = -1 if left else 1
		# labels.text = "callibrating: left" if left else "callibrating: right"
		await get_tree().create_timer(0.01).timeout
		# labels.text = "callibrating: none"
		Volume_calibrations.callib_mode = 0
		
func get_disabled(p_enabled):
	Volume_calibrations.disability = p_enabled
