extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_new_game_pressed():
	print("New Game")
	#get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
	GlobalFuncs_.change_main_scene("res://scenes/levels/level1.tscn")
	WaveManager.start()
