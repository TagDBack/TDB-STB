extends Node

class_name melee_weapon

@export var speed = 20

@onready var origin_rotation = self.transform

@onready var combo1 = $Combo1
@onready var combo2 = $Combo2
@onready var cooldown = $Cooldown
@onready var rotate_to = self.transform.basis
var is_rotating = false

func _physics_process(delta):
	if is_rotating:
		self.transform = self.transform.interpolate_with(rotate_to, speed * delta)
	
	if Input.is_action_just_pressed("action_melee") and not combo1.is_stopped():
		rotate_to = Basis(Vector3.UP, deg_to_rad(120)) * self.transform.basis
		combo1.stop()
		combo2.start()
		cooldown.start()
	elif Input.is_action_just_pressed("action_melee") and not combo2.is_stopped():
		rotate_to = Basis(Vector3.DOWN, deg_to_rad(120)) * self.transform.basis
		combo2.stop()
		cooldown.start()
	elif Input.is_action_just_pressed("action_melee") and cooldown.is_stopped():
		self.visible = true
		is_rotating = true
		rotate_to = Basis(Vector3.DOWN, deg_to_rad(120)) * self.transform.basis
		combo1.start()
		cooldown.start()
		

func _on_cooldown_timeout():
	self.transform = origin_rotation
	self.visible = false
	is_rotating = false
