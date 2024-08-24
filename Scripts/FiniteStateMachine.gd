extends Node2D
 
var current_state: State
var previous_state: State
 
func _ready():
	owner.hurtbox.connect("taking_hit", self, "_on_taking_hit")
	
	current_state = get_child(0) as State
	previous_state = current_state
	current_state.enter()
 
func change_state(state):
	current_state = find_child(state) as State
	current_state.enter()
 
	previous_state.exit()
	previous_state = current_state

func _on_taking_hit(damage):
	if owner.HP <= 0:
		owner.HP = 0
		change_state("Death")
	else:
		change_state("Take_Hit")
