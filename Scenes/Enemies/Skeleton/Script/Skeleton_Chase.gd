extends State

var out_of_range : bool
@onready var chase_range = $"../../Chase Range"

func enter():
	super.enter()
	out_of_range = false
	chase_range.set_deferred("monitoring", true)

func _physics_process(delta):
	if !out_of_range:
		animation_player.play("Walk")
		owner.direction = sign(player.position.x - owner.position.x)
		owner.movement(delta)
	
	transition()

func transition():
	if out_of_range:
		get_parent().change_state("Idle")

func _on_chase_range_body_exited(_body):
	out_of_range = true
	chase_range.set_deferred("monitoring", false)
