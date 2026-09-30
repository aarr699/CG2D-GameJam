extends AnimatedSprite2D

@export_file("*.tscn") var next_scene = "res://Scenes/restart.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("new_animation")
	var frame_count = sprite_frames.get_frame_count("new_animation")
	var fps = sprite_frames.get_animation_speed("new_animation")
	var duration = float(frame_count) / fps
	$Explosion.play()
	await get_tree().create_timer(duration).timeout
	get_tree().change_scene_to_file(next_scene)
	queue_free()
func _on_animation_finished():
	pass
