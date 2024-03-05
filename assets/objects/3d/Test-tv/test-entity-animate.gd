extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input(delta):
	# Move Z
	if Input.is_action_pressed("move_up"): 
		pass
	
	if Input.is_action_pressed("move_down"):
		pass
	
	# Move X
	if Input.is_action_pressed("move_left"):
		pass
	
	if Input.is_action_pressed("move_right"):
		pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input(delta)
