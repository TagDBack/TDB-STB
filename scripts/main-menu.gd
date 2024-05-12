extends Control
var rich_text_label = RichTextLabel
func _ready():	
	$NewGameButton.connect("pressed", _on_new_game_pressed)
	$NewGameButton.get_node("RichTextLabel").connect("meta_clicked", _on_meta_clicked)
	
	$ContinueButton.connect("pressed", _on_continue_pressed)
	$ContinueButton.get_node("RichTextLabel").connect("meta_clicked", _on_meta_clicked)
	
	$ShopButton.connect("pressed", _on_shop_pressed)
	$ShopButton.get_node("RichTextLabel").connect("meta_clicked", _on_meta_clicked)
	
	$SettingsButton.connect("pressed", _on_settings_pressed)
	$SettingsButton.get_node("RichTextLabel").connect("meta_clicked", _on_meta_clicked)
	
	$QuitButton.connect("pressed", _on_quit_pressed)
	$QuitButton.get_node("RichTextLabel").connect("meta_clicked", _on_meta_clicked)
	
func _on_new_game_pressed():
	print("New Game")
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")
	WaveManager.start()
	
func _on_meta_clicked(arg):
	match arg:
		"new_game": _on_new_game_pressed()
		"continue": _on_continue_pressed()
		"shop": _on_shop_pressed()
		"settings": _on_settings_pressed()
		"quit": _on_quit_pressed()

func _on_continue_pressed():
	print("Continue")
	
func _on_shop_pressed():
	print("Shop")

func _on_settings_pressed():
	print("Settings")

func _on_quit_pressed():
	get_tree().quit()
