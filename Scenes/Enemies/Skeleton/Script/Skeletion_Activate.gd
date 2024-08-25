extends State

func enter():
	super.enter()
	
	if owner.line_of_sight != null:
		owner.line_of_sight.enabled = false
	animation_player.stop()

func transition():
	if owner.active:
		get_parent().change_state("Idle")
