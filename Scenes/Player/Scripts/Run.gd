extends State

func enter():
	super.enter()
	animation_player.play("Run")

func _physics_process(delta):
	player.handle_move(delta)
	transition()

func transition():
	if Input.is_action_just_pressed("Jump"):
		get_parent().change_state("Jump")
		
	elif Input.is_action_just_pressed("Dash") and player.can_dash():
		get_parent().change_state("Dash")
		
	elif !player.is_on_floor() and player.coyote_timer.is_stopped():
		get_parent().change_state("Fall")
		
	elif !(Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
		get_parent().change_state("Idle")
		
	elif Input.is_action_pressed("Melee_Attack"):
		get_parent().change_state("Melee_Attack")
	
	elif Input.is_action_pressed("Ranged_Attack"):
		get_parent().change_state("Ranged_Attack")
	
