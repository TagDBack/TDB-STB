extends melee_weapon

#@onready var area_collision = $Area3D
#
#@export var speed = 20
#@export var damage = 10
#
#@onready var origin_rotation = self.transform

#@onready var rotate_to = self.transform.basis
#var is_rotating = false

var stretch_length = 0
var stretch_speed = 15
@export var max_stretch = 3
# From 0 to max_stretch

func _ready():
	area_collision.body_entered.connect(_enemy_on_body_entered)
	stretch_speed = speed
	damage = 0.4 * damage

func _physics_process(delta):
	if stretch_length == 0:
		change_visibility(false)
	else:
		change_visibility(true)
	
	if Input.is_action_pressed("action_melee"):
		if stretch_length != max_stretch:
			stretch_length = min(max_stretch, stretch_length + stretch_speed * delta)
			self.position.z = - stretch_length
	else:
		if stretch_length != 0:
			stretch_length = max(0, stretch_length - stretch_speed * delta)
			self.position.z = - stretch_length

#func change_visibility(trufals):
	#self.visible = trufals
	#self.get_node("Area3D").monitoring = trufals
	#
	#
#func _enemy_on_body_entered(body_entered):
	#if body_entered is enemy:
		#body_entered.take_damage(damage)
