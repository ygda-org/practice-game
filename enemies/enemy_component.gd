extends Node2D

const MAX_HEALTH : float = 10
@export var health : float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HealthBar.value = health/MAX_HEALTH

func increment_health(amount : float):
	health += amount
	$HealthBar.value = health/MAX_HEALTH
	if health <= 0:
		get_parent().queue_free()
