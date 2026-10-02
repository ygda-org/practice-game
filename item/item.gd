extends Area2D

@export var item : BaseItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = item.sprite


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if item.item_name == "coin":
			Gamestate.increment_score(1)
		if item.item_name == "health":
			pass
		queue_free()
