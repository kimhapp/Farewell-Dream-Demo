extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -250.0
const AIR_JUMP_VELOCITY = -225.0
const DASH_SPEED = 450
const GRAVITY = 1000

const FADE_OUT_COLOR = Color(1, 1, 1, 0.25)  # Transparent
const FADE_IN_COLOR = Color(1, 1, 1, 1)   # Fully opaque

var health = 3
var is_air_jumping = false

signal health_change(value)

@onready var animation_player = $AnimationPlayer
@onready var dash_timer = $"Dash Timer"
@onready var dash_delay_timer = $"Dash Delay Timer"
@onready var coyote_timer = $"Coyote Timer"
@onready var invincible_timer = $"Invincible Timer"

func _physics_process(delta):
	# Add the gravity and handle air jump
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		is_air_jumping = false
	
	# Handle dash
	if Input.is_action_just_pressed("dash") and can_dash():
		invincible_timer.start()
		dash_timer.start()
		dash_delay_timer.start()
	
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() || !coyote_timer.is_stopped():
			velocity.y = JUMP_VELOCITY
		elif !is_air_jumping:
			is_air_jumping = true
			velocity.y = AIR_JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("Run")
	else:
		if !is_air_jumping:
			animated_sprite_2d.play("Jump")
	
	# Apply the movement
	if is_dashing():
		animated_sprite_2d.play("Dash")
		if animated_sprite_2d.flip_h:
			direction = -1
		else:
			direction = 1
		velocity.y = 0
		velocity.x = direction * DASH_SPEED
	elif direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()

func _on_dash_timer_timeout():
	invincible_timer.stop()

func is_dashing():
	return !dash_timer.is_stopped()

func can_dash():
	return dash_delay_timer.is_stopped()

func is_invincible():
	return !invincible_timer.is_stopped()

func invincible():
	invincible_timer.start()
	
	# For fading in and out during invincible phase
	var fade_timer = [0.4, 0.4, 0.2, 0.2, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1]
	var colors = [FADE_OUT_COLOR, FADE_IN_COLOR]
	
	for i in range(fade_timer.size()):
		animated_sprite_2d.modulate = colors[i % 2]
		await get_tree().create_timer(fade_timer[i]).timeout

func _on_obstacles_detection_body_entered(body):
	if !is_invincible():
		health -= 1
		emit_signal("health_change", health)
		
		if health <= 0:
			print(str(health))
			invincible()
