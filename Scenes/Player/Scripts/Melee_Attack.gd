extends State

func enter():
	super.enter()
	if !player.is_on_floor():
		player.has_air_attacked = true
		player.velocity.y = 0
	animation_player.play("Melee_Attack")

func _physics_process(delta):
	player.velocity.x = 0
	player.velocity.y += player.ATTACK_GRAVITY * delta
	
	player.move_and_slide()
	transition()

func transition():
	if Input.is_action_just_pressed("Dash") and player.can_dash():
		player.has_air_attacked = false
		get_parent().change_state("Dash")
		
	elif !animation_player.is_playing():
		if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
			get_parent().change_state("Run")
		
		elif Input.is_action_just_pressed("Jump") and player.is_on_floor():
			get_parent().change_state("Jump")
		
		elif Input.is_action_just_pressed("Jump") and !player.is_on_floor() and !player.has_air_jumped:
			player.has_air_attacked = false
			get_parent().change_state("Air_Jumping")
		
		elif Input.is_action_pressed("Ranged_Attack") and !player.has_air_range_attacked:
			get_parent().change_state("Ranged_Attack")
			
		elif player.velocity.y > 0:
			get_parent().change_state("Fall")
			
		else:
			get_parent().change_state("Idle")
