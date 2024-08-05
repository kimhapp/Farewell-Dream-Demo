extends Node2D
class_name State

@onready var player = owner.get_parent().find_child("Player")
@onready var animation_player = owner.find_child("AnimationPlayer")

func _ready():
	set_physics_process(false)

func enter():
	set_physics_process(true)
	print(name, " state entered")

func exit():
	set_physics_process(false)
	print(name, " state exited")

func transition():
	pass

func _physics_process(_delta):
	transition()
