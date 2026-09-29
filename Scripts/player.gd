extends CharacterBody2D

@export var speed = 100
@export var player_health = 100

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
