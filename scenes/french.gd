extends Node3D

signal finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite3D.play("default");
	$AnimationPlayer.play("stretch")

func explode() -> void:
	$ExplosionSprite.show()
	$ExplosionSprite.play()
	$AudioStreamPlayer.play()
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite3D, "modulate", Color.TRANSPARENT, 0.75)
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(finished.emit)


func _on_explosion_sprite_animation_finished() -> void:
	$ExplosionSprite.hide()
