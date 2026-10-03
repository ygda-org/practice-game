extends Node2D

const ITEM = preload("uid://dwo23ij5qusqy")

var max_health : float
@export var health : float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_health = health
	$HealthBar.value = health/max_health


func increment_health(amount : float):
	health += amount
	$HitParticles.emitting = true
	$HealthBar.value = health/max_health
	if health <= 0:
		var item : Item = ITEM.instantiate()
		item.item = load("res://item/items/health.tres")
		item.global_position = get_parent().global_position
		get_parent().get_parent().add_child(item)
		get_parent().queue_free()
	
