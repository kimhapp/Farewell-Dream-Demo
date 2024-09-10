extends CharacterBody2D

@export var animation_tree: AnimationTree

var state_machine : AnimationNodeStateMachinePlayback
var move_state_machine : AnimationNodeStateMachinePlayback
var jump_state_machine : AnimationNodeStateMachinePlayback
var attack_state_machine : AnimationNodeStateMachinePlayback

@export var SPEED = 250.0
@export var ATTACK_GRAVITY = 50

@onready var sprite_2d = $Sprite2D

var direction : float
var on_floor : bool
var has_air_jumped : bool
var has_air_dashed : bool
var has_air_attacked : bool
var has_air_range_attacked : bool

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	state_machine = animation_tree.get("parameters/playback")
	move_state_machine = animation_tree.get("parameters/Movement/playback")
	jump_state_machine = animation_tree.get("parameters/Jump/playback")
	attack_state_machine = animation_tree.get("parameters/Attack/playback")

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	
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
