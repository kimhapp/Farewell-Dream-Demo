extends State

func enter():
	super.enter()
	player.set_physics_process(false)
	player.velocity.y = 0
	animation_player.speed_scale = 2.25
	animation_player.play("Melee_Attack")

func _physics_process(delta):
	if !animation_player.is_playing():
		transition()

func exit():
	super.exit()
	player.set_physics_process(true)
	animation_player.speed_scale = 1

func transition():
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		get_parent().change_state("Run")
		
	elif Input.is_action_just_pressed("Dash") and player.can_dash:
		get_parent().change_state("Dash")
		
	elif Input.is_action_just_pressed("Jump"):
		get_parent().change_state("Jump")
		
	elif Input.is_action_just_pressed("Ranged_Attack"):
		get_parent().change_state("Ranged_Attack")
		
	else:
		get_parent().change_state("Idle")
