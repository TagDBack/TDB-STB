extends melee_weapon

#@onready var area_collision = $Area3D
#
#@export var speed = 20
#@export var damage = 10
#
#@onready var origin_rotation = self.transform

#@onready var rotate_to = self.transform.basis
#var is_rotating = false

@onready var cooldown = $Cooldown

var stretch_length = 0
var stretch_speed = 15
@export var max_strecth = 1
# From 0 to max_strecth

var is_action = false
var outward = false

func _ready():
	area_collision.body_entered.connect(_enemy_on_body_entered)
	#area_collision.body_entered.connect(_bullet_on_body_entered)
	stretch_speed = speed
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

func _retracting(delta):
	if outward:
		if stretch_length != max_strecth:
			stretch_length = min(max_strecth, stretch_length + stretch_speed * delta)
			self.position.z = - stretch_length
		else:
			outward = false
	else:
		if stretch_length != 0:
			stretch_length = max(0, stretch_length - stretch_speed * delta)
			self.position.z = - stretch_length
		else:
			is_action = false

#func change_visibility(trufals):
	#self.visible = trufals
	#self.get_node("Area3D").monitoring = trufals
	#
	#
func _enemy_on_body_entered(body_entered):
	if body_entered is enemy and is_action:
		body_entered.take_damage(damage)
		body_entered.pushed_back()

#func _bullet_on_body_entered(bullet_entered):
	#if bullet_entered is enemy_bullet:
		#enemy_bullet.deflect()
