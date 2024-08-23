extends State

@onready var patrol_timer = $"../../Patrol Timer"

func enter():
	super.enter()
	
	if owner.sprite_2d.flip_h == true:
		owner.direction = 1
	else:
		owner.direction = -1
		
	patrol_timer.start()

func _physics_process(delta):
	if !patrol_timer.is_stopped():
		animation_player.play("Walk")
		owner.movement(delta)
	
	transition()

func transition():
	if patrol_timer.is_stopped():
		get_parent().change_state("Idle")
	else:
		if owner.line_of_sight.is_colliding():
			get_parent().change_state("Chase")
