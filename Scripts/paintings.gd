extends Area2D
@onready var player = get_parent().get_node("Character")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.name == player.name:
		$Label.visible = true
		print("body entered painting")


func _on_body_exited(body: Node2D) -> void:
	$Label.visible = false
