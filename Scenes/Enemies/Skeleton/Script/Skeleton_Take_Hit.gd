extends State

func enter():
	super.enter()
	animation_player.play("Take_Hit")

func _on_animation_player_animation_finished(anim_name):
	get_parent().change_state("Chase")
