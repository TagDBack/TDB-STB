extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func new_wave(wave_number):
	call_deferred("_deferred_new_wave", wave_number)
	
func _deferred_new_wave(wave_number):
	if wave_number == 1:
		spawn("res://scenes/spawners/wave1.tscn")
		assign_weapons()
	elif wave_number == 2:
		spawn("res://scenes/spawners/wave2.tscn")
	else:
		pass

func spawn(spawner_level_path):
	call_deferred("_deferred_spawn", spawner_level_path)
	
func _deferred_spawn(spawner_level_path):
	await get_tree().create_timer(0.1).timeout
	var s = ResourceLoader.load(spawner_level_path)
	var spawner = s.instantiate()
	get_tree().root.add_child(spawner)

func assign_weapons():
	call_deferred("_deferred_assign_weapons")

func _deferred_assign_weapons():
	await get_tree().create_timer(0.1).timeout
	var player = get_tree().get_nodes_in_group("player")
	if len(player) == 0:
		player = null
	else:
		player = player[0]
	
	var melee_weapon_node = null
	if ResourceManager.melee_weapon_selected == "Sword":
		melee_weapon_node = ResourceLoader.load("res://scenes/entities/melee-weapon/sword.tscn").instantiate()
	elif ResourceManager.melee_weapon_selected == "Spear":
		melee_weapon_node = ResourceLoader.load("res://scenes/entities/melee-weapon/spear.tscn").instantiate()
	elif ResourceManager.melee_weapon_selected == "Shield":
		melee_weapon_node = ResourceLoader.load("res://scenes/entities/melee-weapon/shield.tscn").instantiate()
	
	player.get_node("Entity").add_child(melee_weapon_node)
