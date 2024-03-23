extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Wave Number".text = "Wave " + str(WaveManager.wave_number)
	$"Wave Time Left".text = "Until Next Wave " + str(WaveManager.wave_timer.time_left)
