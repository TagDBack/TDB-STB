extends Node

@export var game_mode = "Immortal"
@export var ranged_weapon_selected = "Mid"
@export var melee_weapon_selected = "Sword"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_game_mode(item_selected):
	self.game_mode = item_selected

func change_ranged_weapon_selected(item_selected):
	self.ranged_weapon_selected = item_selected
	
func change_melee_weapon_selected(item_selected):
	self.melee_weapon_selected = item_selected
