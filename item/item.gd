extends Area2D

@export var item : BaseItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = item.sprite
	name = item.item_name


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if name == "coin":
			Gamestate.score += 1
		if name == "health":
			pass
		queue_free()
