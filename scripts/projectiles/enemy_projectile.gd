extends Node3D

class_name EnemyProjectile

var damage = 0.0
@export var speed = 10
@onready var global_funcs = get_node("/root/GlobalFuncs_")
@onready var status_manager = get_node("/root/StatusEffectManager_")
@onready var player = get_node("/root/GlobalFuncs_").get_player()
@onready var area3d = $Area3D

func _ready():
	area3d.body_entered.connect(body_entered)
	pass

func _process(delta):
	position += rotation * speed * delta

func body_entered(body):
	if body.is_in_group("player"):
		player.health -= damage
		global_funcs.shake_camera(20,10,10)
		effect()

func effect():
	pass
