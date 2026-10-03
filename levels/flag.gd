extends Area2D

var raised : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not raised:
		$Anim.play("raise")
		$Confetti.emitting = true
		raised = true
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://ui/start_menu.tscn")
