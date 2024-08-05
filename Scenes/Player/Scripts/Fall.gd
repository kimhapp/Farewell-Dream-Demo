extends State

func enter():
	super.enter()
	animation_player.play("Fall")

func transition():
	if Input.is_action_just_pressed("Jump") and !player.has_air_jumped:
		get_parent().change_state("Air_Jumping")
		
	elif Input.is_action_just_pressed("Dash") and player.can_dash and !player.has_air_dashed:
		get_parent().change_state("Dash")
		
	elif player.is_on_floor():
		if !(Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
			get_parent().change_state("Idle")
		else:
			get_parent().change_state("Run")
		
	elif Input.is_action_just_pressed("Melee_Attack"):
		get_parent().change_state("Melee_Attack")
		
	elif Input.is_action_just_pressed("Ranged_Attack"):
		get_parent().change_state("Ranged_Attack")
