extends CharacterBody2D

@export var SPEED = 250.0
@export var GRAVITY = 1000.0

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var active_range = $"Active Range"

