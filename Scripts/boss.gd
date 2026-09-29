extends CharacterBody2D

var speed = 60
var target_dir: Vector2
@onready var player = get_parent().get_node("Character")
var attack_range = 40
@onready var sprite = $Pivot/Sprite2D
var player_inside_box: bool = false
var damage_cooldown: float = 1.0
var damage_timer: float = 0.0
var health = 100

func _ready() -> void:
	print("Boss Script Initialized")
	print("Looking for player node: ", player)
	if has_node("Pivot/Sprite2D/Area2D"):
		$Pivot/Sprite2D/Area2D.body_entered.connect(_on_area_2d_body_entered)
		print("Success: Area 2D connected through Sprite2D node path!")
		$Pivot/Sprite2D/Area2D.body_exited.connect(_on_area_2d_body_exited)
		
func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		velocity = Vector2.ZERO
		set_physics_process(false)
		print("Player is dead.")
		return
	if player: 
		var vector_to_player = player.position - position
		var distance_to_player = position.distance_to(player.position)
		if damage_timer > 0:
			damage_timer -= delta
		if vector_to_player.x < 0:
			$Pivot.scale.x = -1
		else:
			$Pivot.scale.x = 1
		if player_inside_box and distance_to_player <= attack_range:
			if damage_timer <= 0: 
				if distance_to_player <= attack_range:
					if "player_health" in player:
						velocity = Vector2.ZERO
						if vector_to_player.x > 0:
							$AnimationPlayer.play("boss_right")
						if vector_to_player.x < 0:
							$AnimationPlayer.play("boss_right")
						if player.player_health > 0:
							player.player_health -= 15
						print("Continuous Damage, player health: ", player.player_health)
						damage_timer = damage_cooldown
		if distance_to_player > attack_range:
			target_dir = (player.position - position).normalized()
			velocity = target_dir * speed
			position += velocity * delta
	else:
		print("Critical Error, Cannot find player.")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Area2D touched player.")
	if body == player:
		player_inside_box = true
		damage_timer = 0.0

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player_inside_box = false
