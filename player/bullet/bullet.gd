extends Area2D

class_name Bullet

const SPEED : float = 100.0
const DAMAGE : float = -2.0

var dir : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randf() < 0.5:
		$Note1.visible = false
	else:
		$Note2.visible = false
	rotation_degrees = randf() * 360


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += dir * SPEED * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("EnemyComponent"):
		body.get_node("EnemyComponent").increment_health(DAMAGE)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
