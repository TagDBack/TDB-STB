extends Node

var is_start = false
var wave_number = 0
var wave_timer: Timer = null

# Called when the node enters the scene tree for the first time.
func _ready():	
	start()

func start():
	call_deferred("_deferred_start")
	
func _deferred_start():
	if is_start:
		return
	
	is_start = true
	multiplier = 1
	
	var t = ResourceLoader.load("res://scenes/miscs/wave-timer.tscn")
	var timer = t.instantiate()
	wave_timer = timer
	get_tree().root.add_child(timer)
	
	next_wave()
	
func next_wave():
	call_deferred("_deffered_next_wave")
	
func _deffered_next_wave():
	wave_number += 1
	print(wave_number)
	calculate_multiplier()
	
	if (wave_number >= 16):
		endless_mode_next_wave()
	elif (wave_number % 5 == 0):
		is_boss_wave = true
		print("boss wave")
		
		# Do boss wave spawner here
		# Delete this if the boss has been implemented
		await get_tree().create_timer(5.0).timeout
		boss_death()
		# Delete until this
	else:
		is_boss_wave = false
		print("normal wave")
		
		# Do normal wave spawner here
		wave_timer.start()
