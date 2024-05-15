extends CharacterBody3D

class_name Enemy

@export var hp: float = 1.0
@export var atk: float = 1.0
@export var speed: float = 1.0
@export_range(-100.0, 100.0, 0.1) var kb_res: float = 0.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var global_funcs = get_node("/root/GlobalFuncs_")
@onready var player = global_funcs.get_player()
@onready var main_scene = global_funcs.get_main_scene()

var dir = Vector3.ZERO
var knocked = false
var knocked_dir = null

func _ready():
	add_to_group("enemy")
	more_onready()

func _physics_process(delta):
	dir = Vector3.ZERO
	if !knocked:
		dir = move()
		act()
	else:
		dir = knockback(delta)
		if dir.length() <= 0.1:
			knocked = false
			knocked_dir = null
			speed = 1.0
	velocity = dir
	move_and_slide()

func move():
	dir = player.global_position - global_position
	dir.y = 0
	if !is_on_floor():
		dir.y -= gravity
	dir.normalized()
	return dir * speed

func act():
	pass

func more_onready():
	pass

func take_damage(damage):
	hp -= damage
	knocked = true
	if hp <= 0:
		await get_tree().create_timer(.45).timeout
		queue_free()

func knockback(delta):
	if knocked_dir == null:
		knocked_dir = -(player.global_position - global_position)
	knocked_dir.y = 0
	if !is_on_floor():
		knocked_dir.y -= gravity
	knocked_dir.normalized()
	speed = lerp(speed, 0.0, delta*10)
	return knocked_dir  * speed * (15 * (1-kb_res/100.0))
