extends CharacterBody2D
class_name Player

@export var gravity_curve_ascending: Curve
@export var gravity_curve_descending: Curve

const SPEED = 150.0
const JUMP_VELOCITY = -350.0
const MAX_FALL_SPEED = 300

const GRAVITY = 850

const MAX_HEALTH : float = 20
var health : float = 20


func _physics_process(delta: float) -> void:
	# Gravity.
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += 1.5 * delta * GRAVITY * gravity_curve_descending.sample(velocity.y/MAX_FALL_SPEED)
		else:
			velocity.y += GRAVITY * delta * gravity_curve_ascending.sample(-velocity.y/MAX_FALL_SPEED)
		velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL_SPEED)

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_released("player_jump") and velocity.y < 0:
		velocity.y /= 3

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
