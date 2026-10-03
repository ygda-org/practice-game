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

var in_air: bool = false
@onready var land_particles: CPUParticles2D = $JumpParticles.duplicate()

var target_scale: Vector2 = Vector2(1,1)

func _ready():
	add_child(land_particles)

func _physics_process(delta: float) -> void:
	# Gravity.
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += 1.5 * delta * GRAVITY * gravity_curve_descending.sample(velocity.y/MAX_FALL_SPEED)
		else:
			velocity.y += GRAVITY * delta * gravity_curve_ascending.sample(-velocity.y/MAX_FALL_SPEED)
		velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL_SPEED)
		if velocity.y > 0:
			$Anim.play("fall")
	else:
		if velocity.x:
			$Anim.play("run")
		else:
			$Anim.play("idle")
	if velocity.x > 0:
		$Anim.flip_h = false
	elif velocity.x < 0:
		$Anim.flip_h = true
	# Handle jump.
	if is_on_floor():
		$CoyoteTime.start()
		if in_air:
			land_particles.emitting = true
			target_scale = Vector2(2, 0.5)
		in_air = false
		$RunParticles.emitting = bool(velocity.x)
	else:
		$RunParticles.emitting = false
		in_air = true
	if Input.is_action_just_pressed("player_jump"):
		$JumpBuffer.start()
	if not $JumpBuffer.is_stopped() and not $CoyoteTime.is_stopped():
		$JumpBuffer.stop()
		velocity.y = JUMP_VELOCITY
		$JumpParticles.emitting = true
		target_scale = Vector2(0.4, 1.5)
	if Input.is_action_just_released("player_jump") and velocity.y < 0:
		velocity.y /= 2.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	$Anim.scale = $Anim.scale.lerp(target_scale, delta*25)
	if $Anim.scale.distance_to(target_scale) < 0.1:
		target_scale = Vector2(1,1)
	move_and_slide()
