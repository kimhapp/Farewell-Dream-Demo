extends CharacterBody2D

@export var SPEED = 250.0
@export var GRAVITY = 1000.0

@onready var sprite_2d = $Sprite2D
@onready var line_of_sight = $"../../Line of Sight"

var direction : Vector2
var active : bool

func _ready():
	active = false
	set_physics_process(false)

func _physics_process(delta):
	if direction.x < 0:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
	
	velocity = direction.normalized() * 40
	move_and_slide()

func _on_active_range_body_entered(body):
	active = true
	set_physics_process(true)

func _on_active_range_body_exited(body):
	active = false
	set_physics_process(false)
