class_name HurtBox
extends Area2D

@export var damage_reduction : float
signal taking_hit(damage)

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox : HitBox):
	if hitbox == null:
		return
	
	if owner.find_child("Take_Hit"):
		var damage = hitbox.damage
		var final_dmg = damage * (1.0 - damage_reduction)
		
		owner.HP -= final_dmg
		emit_signal("taking_hit", final_dmg)
