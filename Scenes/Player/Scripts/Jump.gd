extends State

@export var JUMP_VELOCITY = -300.0

func enter():
	super.enter()
	animation_player.play("Jump")
	player.velocity.y = JUMP_VELOCITY

func _physics_process(delta):
	player.handle_move(delta)
	player.flip_sprite()
	transition()

func transition():
	if Input.is_action_just_pressed("Jump") and !player.has_air_jumped:
		get_parent().change_state("Air_Jumping")
		
	if Input.is_action_just_pressed("Dash") and player.can_dash():
		get_parent().change_state("Dash")
		
	elif player.velocity.y > 0:
		get_parent().change_state("Fall")
		
	elif Input.is_action_just_pressed("Melee_Attack") and !player.has_air_attacked:
		get_parent().change_state("Melee_Attack")
		
	elif Input.is_action_just_pressed("Ranged_Attack"):
		get_parent().change_state("Ranged_Attack")
