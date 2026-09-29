extends ProgressBar
var player = get_parent().get_parent().get_node("Character")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		print("Progress bar connection successful!")
	else:
		print("Progress bar connection unsuccessful!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		value = player.player_health
