extends Area2D

class_name Item

@export var item : BaseItem

var time_accum : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = item.sprite

func _physics_process(delta: float) -> void:
	$Sprite2D.position.y = (sin(time_accum) * 2 - 1) * 2
	time_accum += delta

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if item.item_name == "coin":
			Gamestate.increment_score(1)
		if item.item_name == "health":
			Gamestate.increment_health(1)
		queue_free()
