extends State

var out_of_range : bool
var distance: Vector2
@onready var chase_range = $"../../Chase Range"

func enter():
	super.enter()
	out_of_range = false
	chase_range.set_deferred("monitoring", true)

func _physics_process(delta):
	if !out_of_range:
		animation_player.play("Walk")
		distance = player.position - owner.position
		owner.direction = sign(distance.x)
		owner.movement(delta)
	
	transition()

func transition():
	if out_of_range:
		get_parent().change_state("Idle")
	elif distance.length() < 50:
		var chance = randf()
		
		if chance > 0.3:
			get_parent().change_state("Attack")
		else:
			get_parent().change_state("Shield")

func _on_chase_range_body_exited(_body):
	out_of_range = true
	chase_range.set_deferred("monitoring", false)
