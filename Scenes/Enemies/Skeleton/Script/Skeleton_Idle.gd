extends State

@onready var idle_timer = $"../../Idle Timer"

func enter():
	super.enter()
	idle_timer.start()
	owner.line_of_sight.enabled = true
	animation_player.play("Idle")

func transition():
	if !owner.active:
		get_parent().change_state("Deactivate")
	else:
		if owner.line_of_sight.is_colliding():
			get_parent().change_state("Chase")
		if idle_timer.is_stopped():
			get_parent().change_state("Patrol")
