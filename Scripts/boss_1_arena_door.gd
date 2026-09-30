extends Area2D

@onready var player = get_parent().get_node("Character")


func _on_body_entered(body: Node2D) -> void:
	if player:
		if player.boss_key == 1:
			$AnimatedSprite2D.play("default")
			$door_collision.set_deferred("disabled", true)


func _on_body_exited(body: Node2D) -> void:
	if player:
		if player.boss_key == 1:
			$AnimatedSprite2D.play_backwards("default")
