extends Node

@export var item_name = ""
@export var group_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if group_name == "game_mode":
		ResourceManager.change_game_mode(self.item_name)
	elif group_name == "ranged_weapon":
		ResourceManager.change_ranged_weapon_selected(self.item_name)
	elif group_name == "melee_weapon":
		ResourceManager.change_melee_weapon_selected(self.item_name)
