extends Node2D
var player_in_region: bool = false
var used: bool = false
@onready var text_label: Label = $Area2D/Label
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	text_label.visible = false

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	$AnimatedSprite2D.play("chest_open")
	player_in_region = true
	$AnimatedSprite2D.play("chest_open")
	player_in_region = true
	if not used:
		text_label.visible = true
	else:
		text_label.visible = false

@warning_ignore("unused_parameter")
func _on_area_2d_body_exited(body: Node2D) -> void:
	$AnimatedSprite2D.play_backwards("chest_open")
	player_in_region = false
	text_label.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_chest"):
		print("Interaction Attempted")
		text_label.visible = false
		if player_in_region and not used:
			@warning_ignore("shadowed_global_identifier")
			var char = get_parent().get_node("Character")
			if char:
				char.ammo = 10
				print("Ammo updated!")
		used = true
