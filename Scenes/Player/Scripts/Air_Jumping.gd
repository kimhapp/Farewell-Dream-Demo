extends State

@export var AIR_JUMP_VELOCITY = -250.0

func enter():
	super.enter()
	player.has_air_jumped = true
	animation_player.play("Jump")
	
	player.velocity.y = AIR_JUMP_VELOCITY

func _physics_process(delta):
	player.handle_move(delta)
	transition()

func transition():
	if Input.is_action_just_pressed("Dash") and player.can_dash() and !player.has_air_dashed:
		get_parent().change_state("Dash")
		
	elif player.velocity.y > 0:
		get_parent().change_state("Fall")
		
	elif Input.is_action_just_pressed("Melee_Attack") and !player.has_air_attacked:
		get_parent().change_state("Melee_Attack")
		
	elif Input.is_action_just_pressed("Ranged_Attack"):
		get_parent().change_state("Ranged_Attack")
