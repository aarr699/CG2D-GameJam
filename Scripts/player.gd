extends CharacterBody2D
const Bullet = preload("res://Scenes/bullet.tscn")
@onready var muzzle: Marker2D = $Muzzle
var is_dead: bool = false
signal health_changed(new_health)
const death = preload("res://Scenes/death.tscn")
@onready var ammo_label = $CanvasLayer3/Label
@export var speed = 100
var boss_key: int:
	set(val):
		boss_key = val
		if val == 1:
			$CanvasLayer/Label.text = "Boss-Key Acquired!"
@export var player_health = 100:
	set(val):
		if val == null:
			return
		player_health = val
		health_changed.emit(val)
		if player_health <= 0 and not is_dead:
			die()
@export var ammo = 5:
	set(val):
		ammo = val
		if is_node_ready():
			if ammo >= 0:
				ammo_label.text = "Ammo: " + str(ammo)
			else:
				ammo_label.text = "Ammo: 0"
@onready var boss = get_parent().get_node("Boss")
func _ready() -> void:
	ammo_label.text = "Ammo: " + str(ammo)
@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	$Pivot.look_at(get_global_mouse_position())
	$Muzzle.look_at(get_global_mouse_position())
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
	if Input.is_action_just_pressed("shoot"):
		shoot()

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

func shoot():
	ammo -= 1
	if ammo > 0:
		$BulletNoise.play()
		var new_bullet = Bullet.instantiate()
		new_bullet.global_transform = muzzle.global_transform
		get_tree().root.add_child(new_bullet)
	print("ammo: ", ammo)
	if $Pivot/Gun/RayCast2D.is_colliding():
		var collider = $Pivot/Gun/RayCast2D.get_collider()
		print("Colliding with: ", collider.name)
		if collider.is_in_group("Boss"):
			if ammo > 0:
				boss.boss_health -= 100
				print("Boss health decreased by 10!")
			else:
				print("ammo khatam")
		else:
			print("Bullet Missed!")
	
