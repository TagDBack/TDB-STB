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
	
	var t = ResourceLoader.load("res://scenes/miscs/wave-timer.tscn")
	var timer = t.instance()
	wave_timer = timer
	get_tree().root.add_child(timer)
	
	next_wave()
	
func next_wave():
	call_deferred("_deffered_next_wave")
	
func _deffered_next_wave():
	wave_number += 1
	print(wave_number)
	
	if (wave_number % 5 == 0):
		print("boss wave")
		
		# Do boss wave spawner here
		yield(get_tree().create_timer(5.0), "timeout")
		next_wave()
	else:
		print("normal wave")
		
		# Do normal wave spawner here
		wave_timer.start()
