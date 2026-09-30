extends Area2D
var used:bool = false
@onready var player = get_parent().get_node("Character")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("open_chest") and not used:
		print("open_chest!")
		key()

func _on_body_entered(body: Node2D) -> void:
	$Label.visible = true
	print("Body Entered!")

func _on_body_exited(body: Node2D) -> void:
	$Label.visible = false

func key():
	if player:
		used = true
		player.boss_key = 1
		print("Boss-Key: ", player.boss_key)
		await get_tree().create_timer(1).timeout
		queue_free()
	else:
		print("Player not found.")
