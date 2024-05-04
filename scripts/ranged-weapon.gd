extends Node

class_name ranged_weapon

@export var bullet_pack: PackedScene

@export var speed = 20
@export var damage = 10

@onready var origin_rotation = self.transform

@onready var cooldown = $Cooldown
@onready var rotate_to = self.transform.basis
var is_rotating = false

func _physics_process(delta):
	if is_rotating:
		self.transform = self.transform.interpolate_with(rotate_to, speed * delta)
	
	if Input.is_action_pressed("action_shoot") and cooldown.is_stopped():
		change_visibility(true)
		is_rotating = true
		rotate_to = Basis(Vector3.UP, deg_to_rad(10)) * self.transform.basis
		cooldown.start()
		shoot()

func shoot():
	call_deferred("_deferred_shoot")

func _deferred_shoot():
	var b = bullet_pack.instantiate()
	b.transform = self.global_transform
	b.speed = 20
	b.damage = 10
	b.position += - b.transform.basis.z
	get_tree().get_root().add_child(b)
	

func _on_cooldown_timeout():
	self.transform = origin_rotation
	change_visibility(false)
	is_rotating = false

func change_visibility(trufals):
	self.visible = trufals
