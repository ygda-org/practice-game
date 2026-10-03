extends CharacterBody2D

const SPEED : float = 50.0
const GRAVITY = 400
const CONTACT_DAMAGE : float = -1.5

var is_touching_wall : bool = false
var dir : Vector2 = Vector2.UP

func _ready() -> void:
	velocity = dir * SPEED

func _physics_process(delta: float) -> void:
	if not is_on_wall():
		is_touching_wall = false
	
	for i in range(get_slide_collision_count()):
		var collision : KinematicCollision2D = get_slide_collision(i)
		var body = collision.get_collider()
		if body is Player:
			Gamestate.increment_health(CONTACT_DAMAGE)
	
	move_and_slide()

func _on_dir_switch_timeout() -> void:
	dir *= -1
	velocity = dir * SPEED
	$DirSwitch.start()
