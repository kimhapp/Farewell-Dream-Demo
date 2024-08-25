extends Area2D

@export var ARROW_SPEED = 700

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var player = get_parent().find_child("Player")

var velocity : Vector2 = Vector2.ZERO
var direction : float

func _ready():
	if player.sprite_2d.flip_h:
		animated_sprite_2d.flip_h = true
		direction = -1
	else:
		animated_sprite_2d.flip_h = false
		direction = 1

func _physics_process(delta):
	velocity.x = direction * ARROW_SPEED
	
	position.x += velocity.x * delta

func _on_body_entered(_body):
	queue_free()
