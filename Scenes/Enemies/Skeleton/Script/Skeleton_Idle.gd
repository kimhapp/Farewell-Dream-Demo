extends State

@onready var idle_timer = $"../../Idle Timer"

func enter():
	super.enter()
	idle_timer.wait_time = randf_range(3.0, 6.0)
	idle_timer.start()
	owner.line_of_sight.enabled(true)
	animation_player.play("Idle")

func transition():
	if !owner.active:
		get_parent().change_state("Deactivate")
	else:
		if owner.line_of_sight.collide_with_bodies:
			pass
		elif idle_timer.is_stopped():
			get_parent().change_state("Patrol")
