class_name HurtBox
extends Area2D

@export var damage_reduction : float

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox : HitBox):
	if hitbox == null:
		return
	
	if owner.find_child("Take_Hit"):
		owner.take_hit(hitbox.damage, damage_reduction)
