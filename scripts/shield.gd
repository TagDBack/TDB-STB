extends melee_weapon

#@onready var area_collision = $Area3D
#
#@export var speed = 20
#@export var damage = 10
#
#@onready var origin_rotation = self.transform

#@onready var rotate_to = self.transform.basis
#var is_rotating = false

@onready var area_collision_shape = $Area3D/CollisionShape3D.shape
@onready var area_collsion_shape_size_x = area_collision_shape.size.x
@onready var area_collsion_shape_size_z = area_collision_shape.size.z
@onready var cooldown = $Cooldown
@onready var cooldown_sign = $CooldownSign

var stretch_length = 0
var stretch_speed = 15
var stretch_size_multiply = 5
@export var max_strecth = 2
# From 0 to max_strecth

var is_action = false
var outward = false

func _ready():
	area_collision.body_entered.connect(_enemy_on_body_entered)
	#area_collision.body_entered.connect(_bullet_on_body_entered)
	stretch_speed = speed * 2
	damage = 0.1 * damage

func _physics_process(delta):
	if is_action:
		_retracting(delta)
	
	if Input.is_action_just_pressed("action_melee") and cooldown.is_stopped():
		area_collision.monitoring = false
		area_collision.monitoring = true
		is_action = true
		outward = true
		cooldown.start()
		cooldown_sign.visible = false

func _retracting(delta):
	if outward:
		area_collision_shape.size.x = stretch_size_multiply * area_collsion_shape_size_x
		area_collision_shape.size.z = stretch_size_multiply * area_collsion_shape_size_z
		if stretch_length != max_strecth:
			stretch_length = min(max_strecth, stretch_length + stretch_speed * delta)
			self.position.z = - stretch_length
		else:
			outward = false
	else:
		area_collision_shape.size.x = area_collsion_shape_size_x
		area_collision_shape.size.z = area_collsion_shape_size_z
		if stretch_length != 0:
			stretch_length = max(0, stretch_length - stretch_speed * delta)
			self.position.z = - stretch_length
		else:
			is_action = false

func _on_cooldown_timeout():
	cooldown_sign.visible = true

#func change_visibility(trufals):
	#self.visible = trufals
	#self.get_node("Area3D").monitoring = trufals
	#
	#
func _enemy_on_body_entered(body_entered):
	if body_entered is Enemy and is_action:
		body_entered.knocked_constant = 3.0
		body_entered.take_damage(damage)

#func _bullet_on_body_entered(bullet_entered):
	#if bullet_entered is enemy_bullet:
		#enemy_bullet.deflect()
