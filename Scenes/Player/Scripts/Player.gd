extends CharacterBody2D

@export var SPEED = 250.0
@export var GRAVITY = 1000.0
var direction : float
var has_air_jumped : bool
var has_air_dashed : bool

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var dash_delay_timer = $"Dash Delay Timer"
@onready var coyote_timer = $"Coyote Timer"

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	
	direction = Input.get_axis("Left", "Right")
	
	velocity.x = direction * SPEED
	
	if direction > 0:
		sprite_2d.flip_h = false
	elif direction < 0:
		sprite_2d.flip_h = true
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor && !is_on_floor():
		print("COyote Timer start")
		coyote_timer.start()
	
	if is_on_floor():
		has_air_dashed = false
		has_air_jumped = false

func can_dash():
	return dash_delay_timer.is_stopped()
