extends CharacterBody2D

@export var animation_tree: AnimationTree

var state_machine : AnimationNodeStateMachinePlayback
var move_state_machine : AnimationNodeStateMachinePlayback
var jump_state_machine : AnimationNodeStateMachinePlayback
var combat_state_machine : AnimationNodeStateMachinePlayback

var speed = 250.0

@onready var sprite_2d = $Sprite2D
@onready var coyote_timer = $"Coyote Timer"
@onready var animation_player = $AnimationPlayer

var direction : float
var counter : int = 0
var delay : float

var on_floor : bool:
	set(value):
		if value == on_floor:
			return
		
		on_floor = value
		if value == true:
			state_machine.travel("Movement")
			
			has_air_jumped = false
			has_air_attacked = false
		else:
			state_machine.travel("Jump")

var has_air_jumped : bool
var has_air_dashed : bool
var has_air_attacked: bool
var has_air_range_attacked : bool

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	state_machine = animation_tree.get("parameters/playback")
	move_state_machine = animation_tree.get("parameters/Movement/playback")
	jump_state_machine = animation_tree.get("parameters/Jump/playback")
	combat_state_machine = animation_tree.get("parameters/Combat/playback")

func _physics_process(delta):
	if !is_on_floor():
		if combat_state_machine.is_playing():
			velocity.y = 0
		elif jump_state_machine.is_playing():
			velocity.y += gravity * delta
	
	direction = Input.get_axis("Left", "Right")
	velocity.x = direction * speed
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	on_floor = is_on_floor()
	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
	
	if velocity == Vector2.ZERO:
		set_motion(false)
	else:
		set_motion(true)
	
	flip_sprite()
	controls()

func controls():
	if Input.is_action_just_pressed("Jump") and !combat_state_machine.is_playing():
		if !is_on_floor():
			if !has_air_jumped:
				has_air_jumped = true
				velocity.y = -300.0
		else:
			velocity.y = -350.0
		state_machine.travel("Jump")
	
	if Input.is_action_just_pressed("Melee_Attack") and delay <= 0:
		if !is_on_floor():
			if has_air_attacked:
				return
		
		counter += 1
		if counter == 2:
			has_air_attacked = true
		melee_attack()

func flip_sprite():
		if direction > 0:
			sprite_2d.flip_h = false
		elif direction < 0:
			sprite_2d.flip_h = true

func set_speed(value : int = 250):
	speed = value

func play_combat(anim_name : String):
	combat_state_machine.travel(anim_name)
	state_machine.travel("Combat")
	set_speed(0)

func melee_attack():
	if counter == 1:
		play_combat("Attack_1")
	else:
		play_combat("Attack_2")
		counter = 0

func set_motion(value : bool):
	animation_tree.set("parameters/Movement/conditions/can_run", value)
	animation_tree.set("parameters/Movement/conditions/is_stopped", not value)
