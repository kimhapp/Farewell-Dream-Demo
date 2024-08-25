extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $DamageBar

var health = 0.0 : set = set_health_bar

func set_health_bar(new_health):
	var previous_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
		return
	
	if health < previous_health:
		timer.start()

func init_health_bar(initial_health):
	max_value = initial_health
	value = initial_health
	damage_bar.max_value = initial_health
	damage_bar.value = initial_health

func _on_timer_timeout():
	damage_bar.value = health
