extends State

@export var arrow_scene : PackedScene
@onready var arrow_node = $"../../Arrow"

func enter():
	super.enter()
	if !player.is_on_floor():
		player.has_air_range_attacked = true
		player.velocity.y = 0
	animation_player.play("Ranged_Attack")

func shoot():
	var arrow = arrow_scene.instantiate()
	arrow.position = arrow_node.global_position
	get_tree().current_scene.add_child(arrow)

func _physics_process(delta):
	player.velocity.x = 0
	player.velocity.y += player.ATTACK_GRAVITY * delta
	
	player.move_and_slide()
	transition()

func transition():
	if Input.is_action_just_pressed("Dash") and player.can_dash():
		player.has_air_range_attacked = false
		get_parent().change_state("Dash")
		
	elif !animation_player.is_playing():
		if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
			get_parent().change_state("Run")
		
		elif Input.is_action_just_pressed("Jump") and player.is_on_floor():
			get_parent().change_state("Jump")
		
		elif Input.is_action_just_pressed("Jump") and !player.is_on_floor() and !player.has_air_jumped:
			player.has_air_range_attacked = false
			get_parent().change_state("Air_Jumping")
		
		elif Input.is_action_pressed("Melee_Attack") and !player.has_air_attacked:
			get_parent().change_state("Melee_Attack")
			
		elif player.velocity.y > 0:
			get_parent().change_state("Fall")
			
		else:
			get_parent().change_state("Idle")
