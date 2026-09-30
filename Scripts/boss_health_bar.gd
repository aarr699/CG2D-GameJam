extends TextureProgressBar
@onready var boss = get_tree().current_scene.get_node_or_null("Boss")

func _ready() -> void:
	value = boss.boss_health

func _process(delta: float) -> void:
	if boss: 
		boss.boss_health_changed.connect(_on_boss_health_changed)

func _on_boss_health_changed(boss_new_health):
	value = boss_new_health
	print("Boss Health: ", boss_new_health)
