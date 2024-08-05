extends State

@onready var attack_interval = $"../../Attack Interval"

func enter():
	super.enter()
	animation_player.play("Melee_Attack3")
	player.velocity.x += 300
	player.set_physics_process(false)
	
	attack_interval.start()

func _physics_process(delta):
	if !animation_player.is_playing():
		transition()

func exit():
	super.exit()
	animation_player.speed_scale = 1
	player.set_physics_process(true)

func transition():
	if attack_interval.is_stopped():
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
