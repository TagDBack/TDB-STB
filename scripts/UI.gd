extends Control


var container

# Called when the node enters the scene tree for the first time.
func _ready():
	container = $"MarginContainer/HBoxContainer/VBoxContainer2"
	await get_tree().create_timer(1).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	container.get_node("Wave Number").text = "Wave " + str(WaveManager.wave_number)
	if WaveManager.is_boss_wave:
		container.get_node("Wave Time Left").text = "Defeat The Boss"
	elif WaveManager.is_wave_halt:
		container.get_node("Wave Time Left").text = "Defeat Some Enemies First"
	else:
		var time_left = int(ceil(WaveManager.wave_timer.time_left))
		container.get_node("Wave Time Left").text = str(int(time_left / 60)) + ' : ' + str(time_left % 60)

# https://forum.godotengine.org/t/how-to-round-to-a-specific-decimal-place/27552/3
func ceil_to_dec(num, digit):
	return ceil(num * pow(10.0, digit)) / pow(10.0, digit)
