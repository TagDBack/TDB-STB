extends Node

class_name bullet

@onready var area_collision = $Area3D

@export var speed = 20
@export var damage = 10

func _ready():
	area_collision.body_entered.connect(_enemy_on_body_entered)
	area_collision.area_entered.connect(_border_on_area_entered)

func _physics_process(delta):
	self.position += - self.transform.basis.z * speed * delta
	
func _enemy_on_body_entered(body_entered):
	if body_entered is enemy:
		body_entered.take_damage(damage)
		self.queue_free()

func _border_on_area_entered(area_entered):
	if area_entered is enemy:
		self.queue_free()
