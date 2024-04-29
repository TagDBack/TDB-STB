extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func new_wave(wave_number):
	call_deferred("_deferred_new_wave", wave_number)
	
func _deferred_new_wave(wave_number):
	if wave_number == 1:
		spawn("res://scenes/spawners/wave1.tscn")
	elif wave_number == 2:
		spawn("res://scenes/spawners/wave2.tscn")
	else:
		pass

func spawn(spawner_level_path):
	call_deferred("_deferred_spawn", spawner_level_path)
	
func _deferred_spawn(spawner_level_path):
	var s = ResourceLoader.load(spawner_level_path)
	var spawner = s.instantiate()
	get_tree().root.add_child(spawner)
