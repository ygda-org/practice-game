extends CharacterBody2D

const SPEED : float = 50.0
const GRAVITY = 400

var is_touching_wall : bool = false
var dir : Vector2 = Vector2.LEFT

func _ready() -> void:
	velocity = dir * SPEED

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += GRAVITY * delta
	
	if is_on_wall() and not is_touching_wall:
		dir *= -1
		velocity = dir * SPEED
		is_touching_wall = true
	
	if not is_on_wall():
		is_touching_wall = false
	
	move_and_slide()
