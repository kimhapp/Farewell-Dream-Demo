extends State

func enter():
	super.enter()
	animation_player.stop()

func transition():
	if owner.active:
		get_parent().change_state("Idle")
