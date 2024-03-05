extends KinematicBody


export (int) var movementSpeed = 14
export (int) var sprintSpeedMult = 2
export (int) var vDir = 0
export (int) var hDir = 0

# Export Z axis position

var velocity = Vector3.ZERO
const UP = Vector3(0,-1,0)
const gravity = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_input(delta):
	var speed = movementSpeed
	var direction = Vector3.ZERO
	
	# Check Sprinting
	if Input.is_action_pressed("move_sprint"):
		speed = sprintSpeedMult * movementSpeed
	
	# Move Z
	if Input.is_action_pressed("move_up"): 
		direction.z -= 1
	
	if Input.is_action_pressed("move_down"):
		direction.z += 1
		
	if Input.is_action_pressed("move_left"): 
		#direction.z -= 1
		pass
	
	if Input.is_action_pressed("move_right"):
		#direction.z += 1
		pass
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#$Pivot.look_at(translation + direction, Vector3.UP)
	
	# Ground velocity
	velocity.z = direction.z * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input(delta)
	
	# Moving the character
	velocity = move_and_slide(velocity, Vector3.UP)
