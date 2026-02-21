extends CheckBox


func _ready() -> void:
	toggled.connect(ambienceModeTogle)

func ambienceModeTogle(p_value) -> void:
	Volume_calibrations.calibrating_ambience = p_value
	print(p_value)

	