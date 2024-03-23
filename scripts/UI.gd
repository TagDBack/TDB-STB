extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Wave Number".text = "Wave " + str(WaveManager.wave_number)
	if WaveManager.is_boss_wave:
		$"Wave Time Left".text = "Defeat The Boss"
	else:
		$"Wave Time Left".text = str(ceil_to_dec(WaveManager.wave_timer.time_left, 1))

# https://forum.godotengine.org/t/how-to-round-to-a-specific-decimal-place/27552/3
func ceil_to_dec(num, digit):
	return ceil(num * pow(10.0, digit)) / pow(10.0, digit)
