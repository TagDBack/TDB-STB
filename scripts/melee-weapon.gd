extends Node

class_name melee_weapon

@onready var area_collision = $Area3D

@export var speed = 20
@export var damage = 10

@onready var origin_rotation = self.transform

@onready var rotate_to = self.transform.basis
var is_rotating = false

func _ready():
	area_collision.body_entered.connect(_enemy_on_body_entered)

func _physics_process(delta):
	pass

func change_visibility(trufals):
	self.visible = trufals
	self.get_node("Area3D").monitoring = trufals
	
func _enemy_on_body_entered(body_entered):
	if body_entered is enemy:
		body_entered.take_damage(damage)
