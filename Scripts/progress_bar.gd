extends TextureProgressBar
@onready var player = get_tree().current_scene.get_node_or_null("Character")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		print("Progress bar connection successful!")
		value = player.player_health
		player.health_changed.connect(_on_player_health_changed)
	else:
		print("Progress bar connection unsuccessful!")

func _on_player_health_changed(new_health):
	value = new_health
	print("NEW VALUE!", value)
