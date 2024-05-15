extends EnemyRanged

var can_act = false
var acting = false
@onready var rng = RandomNumberGenerator.new()
@onready var skeleton = preload("res://scenes/entities/enemy/skeleton.tscn")
@onready var witch = preload("res://scenes/entities/enemy/witch.tscn")
@onready var orc_zombie = preload("res://scenes/entities/enemy/orc_zombie.tscn")

func more_onready():
	rng.randomize()

func act():
	if can_act:
		can_act = false
		acting = true
		var act = rng.randi_range(0, 1)
		if act == 0:
			summon_army()
		else:
			shoot_barrage()
	if acting:
		dir *= 0.5

func summon_army():
	summon(3)
	for i in range(15):
		await get_tree().create_timer(0.5).timeout
		summon(rng.randi_range(1, 2))
	acting = false
	$ActCooldown.start()

func summon(type:int):
	var instance = null
	if type == 1:
		instance = skeleton.instantiate()
	elif type == 2:
		instance = witch.instantiate()
	else:
		instance = orc_zombie.instantiate()
	
	instance.global_position.x = global_position.x + randf_range(5.0, 10.0)
	instance.global_position.z = global_position.z + randf_range(5.0, 10.0)
	instance.global_position.y = global_position.y + 5.0
	
	main_scene.add_child(instance)

func shoot_barrage():
	for i in range(100):
		await get_tree().create_timer(0.2).timeout
		shoot()
	acting = false
	$ActCooldown.start(10.0)

func _on_act_cooldown_timeout():
	can_act = true
