extends State

@export var DASH_SPEED = 500.0
@onready var dash_timer = $"../../Dash Timer"

func enter():
	super.enter()
	animation_player.play("Dash")
	
	if player.sprite_2d.flip_h:
		player.direction = -1
	else:
		player.direction = 1
	
	dash_timer.start()
	
	player.velocity.x = player.direction * DASH_SPEED
	player.velocity.y = 0
	
	if !player.is_on_floor():
		player.has_air_dashed = true
	
	player.dash_delay_timer.start()
	
	player.set_physics_process(false)

func exit():
	super.exit()
	player.set_physics_process(true)

func _physics_process(_delta):
	player.move_and_slide()
	transition()

func transition():
	if dash_timer.is_stopped():
		if Input.is_action_just_pressed("Jump"):
			get_parent().change_state("Jump")
			
		elif !player.is_on_floor() and player.coyote_timer.is_stopped():
			get_parent().change_state("Fall")
			
		elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
			get_parent().change_state("Run")
			
		elif Input.is_action_just_pressed("Melee_Attack"):
			get_parent().change_state("Melee_Attack")
			
		elif Input.is_action_just_pressed("Ranged_Attack"):
			get_parent().change_state("Ranged_Attack")
			
		else:
			get_parent().change_state("Idle")
