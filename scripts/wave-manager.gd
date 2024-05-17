extends Node

var is_start = false
var is_boss_wave = false
@export var wave_number = 0
@export var wave_timer: Timer = null
@export var multiplier: int = 0
@export var game_ready = false
@export var is_wave_halt = false
@export var is_end_of_beta = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start():
	call_deferred("_deferred_start")
	
func _deferred_start():
	if is_start:
		return
		
	var ui = ResourceLoader.load("res://scenes/ui/UI.tscn")
	var ui_node = ui.instantiate()
	get_tree().root.add_child(ui_node)
	
	is_start = true
	multiplier = 1
	
	var t = ResourceLoader.load("res://scenes/miscs/wave-timer.tscn")
	var timer = t.instantiate()
	wave_timer = timer
	get_tree().root.add_child(timer)
	
	next_wave()
	
func next_wave():
	if not game_ready:
		await get_tree().create_timer(0.1).timeout
		next_wave()
	if GlobalFuncs_.enemies_left > 30:
		call_deferred("_deferred_wave_halt")
	else:
		is_wave_halt = false
		call_deferred("_deffered_next_wave")
	
func _deffered_next_wave():
	wave_number += 1
	print(wave_number)
	calculate_multiplier()
	
	SpawnManager.new_wave(wave_number)
	
	if (wave_number >= 31):
		endless_mode_next_wave()
	elif (wave_number % 10 == 0):
		is_boss_wave = true
		print("boss wave")
	elif (wave_number > 10):
		is_end_of_beta = true
	else:
		is_boss_wave = false
		print("normal wave")
		
		# Do normal wave spawner here
		wave_timer.start()
		
func _deferred_wave_halt():
	is_wave_halt = true
	await get_tree().create_timer(0.3).timeout
	next_wave()
		
func endless_mode_next_wave():
	call_deferred("_deferred_endless_mode_next_wave")
	
func _deferred_endless_mode_next_wave():
	#
	# Call different function if desired
	#
	if (wave_number % 10 == 0):
		is_boss_wave = true
		print("endless mode boss wave")
	else:
		is_boss_wave = false
		print("endless mode normal wave")
		
		# Do normal wave spawner here
		wave_timer.start()

# Call this function when the boss death
func boss_death():
	call_deferred("_deferred_boss_death")
	
func _deferred_boss_death():
	if wave_number % 10 == 0 and is_boss_wave:
		is_boss_wave = false
		next_wave()

func calculate_multiplier():
	call_deferred("_deferred_calculate_multiplier")
	
func _deferred_calculate_multiplier():
	multiplier = wave_number
