extends Enemy
class_name EnemyRanged

@onready var cooldown = $Cooldown
@export var projectile: PackedScene
@export var atk_speed = 1
@export var atk_range = 5
var can_attack = true

func more_onready():
	cooldown.timeout.connect(cooldown_timeout)

func act():
	var distance = global_position.distance_to(player.global_position)
	if distance < atk_range:
		dir = Vector3.ZERO
		if can_attack:
			can_attack = false
			cooldown.start(1.0/atk_speed)
			shoot()

func shoot():
	var instance = projectile.instantiate()
	instance.damage = atk
	instance.global_position = global_position
	instance.rotation = (player.global_position - global_position).normalized()
	main_scene.add_child(instance)
	#global_funcs.shake_camera(20,10,10)

func cooldown_timeout():
	can_attack = true
