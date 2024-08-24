extends CharacterBody2D

@export var SPEED = 40.0
@export var GRAVITY = 1000.0
@export var HP = 100.0

@onready var sprite_2d = $Sprite2D
@onready var line_of_sight = $"Line of Sight"

var direction : float
var active : bool

func _ready():
	active = false
	set_physics_process(false)

func movement(delta):
	velocity.x = direction * SPEED
	
	if !is_on_floor():
		velocity.y = GRAVITY * delta
	
	if direction > 0:
		sprite_2d.flip_h = false
	elif direction < 0:
		sprite_2d.flip_h = true
	
	move_and_slide()

func _on_active_range_body_entered(body):
	active = true
	set_physics_process(true)

func _on_active_range_body_exited(body):
	active = false
	set_physics_process(false)
