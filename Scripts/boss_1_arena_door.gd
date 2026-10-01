extends Area2D

@onready var player = get_parent().get_node("Character")

func _ready():
	$StaticBody2D/door_collision.set_deferred("disable", false)
	print("door key collision closed")
func _on_body_entered(body: Node2D) -> void:
	if player:
		if player.boss_key == 1:
			print("player boss key led to open door")
			$AnimatedSprite2D.play("default")
			print("Door Key Collision Open")
			$StaticBody2D/door_collision.set_deferred("disabled", true)
		else:
			$StaticBody2D/door_collision.set_deferred("disabled", false)


func _on_body_exited(body: Node2D) -> void:
	if player:
		if player.boss_key == 1:
			$AnimatedSprite2D.play_backwards("default")
