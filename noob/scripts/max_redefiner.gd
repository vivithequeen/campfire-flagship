extends CheckBox

@export var theone: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggled.connect(ts_toggled)

func ts_toggled(p_value):
	theone.setting_max = p_value
