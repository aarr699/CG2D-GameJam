extends CharacterBody2D
var is_dead: bool = false
signal health_changed(new_health)
const death = preload("res://Scenes/death.tscn")
@export var speed = 100
@export var player_health = 100:
	set(val):
		if val == null:
			return
		player_health = val
		health_changed.emit(val)
		if player_health <= 0 and not is_dead:
			die()


@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	if velocity.x > 0:
		$AnimatedSprite2D.play("Right")
		$AnimatedSprite2D.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite2D.play("Left")
		$AnimatedSprite2D.flip_h = true
	if velocity.y < 0:
		$AnimatedSprite2D.play("Up")
	if velocity.y > 0:
		$AnimatedSprite2D.play("Down")
	if velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite2D.play("Idle")
func die() -> void:
	is_dead = true
	set_physics_process(false)
	var camera = get_node_or_null("Camera2D")
	if camera:
		var cam_world_pos = camera.global_position
		remove_child(camera)
		get_parent().add_child(camera)
		camera.global_position = cam_world_pos
	var exp_spawn = global_position
	var death_animation = death.instantiate()
	get_parent().add_child(death_animation)
	death_animation.global_position = exp_spawn
	queue_free()
