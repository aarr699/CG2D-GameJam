extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if abs(rotation) > PI/2:
		$Gun/Sprite2D.flip_v = true
	else:
		$Gun/Sprite2D.flip_v = false
