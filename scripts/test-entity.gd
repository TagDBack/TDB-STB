extends CharacterBody3D

# Movement
var baseSpeed = 10
@export var sRate = 1.0
@export var sprintMult = 1.5
var isSprinting = false
var friction = 20

# Dash 
var dTime = false
var dash = 10

# Sliding
var baseAccel = 2
var isSliding = false
var slideS = 50
var maxSpeed = 30

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var down = up_direction.inverse()

@export var health = 100

var damage = 10
@export var dmMult = 1.0
@export var dnRate = 1.0

@export var size = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	motion_mode = MOTION_MODE_GROUNDED 
	# Player only
	floor_max_angle = 1.0472
	max_slides = 18
	# Enemy only
	# floor_block_on_wall = false


func inputs():
	var dir = Vector3.ZERO
	
	# Normal Movement
	dir.z = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	dir.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))

	dir.normalized()

	# Dash mechanic?
	if Input.is_action_just_pressed("move_sprint"):
		dir = dashing(dir)

	# Sprinting
	isSprinting = Input.is_action_pressed("move_sprint")

	# Sliding
	isSliding = Input.is_action_pressed("move_slide")

	return dir

func dashing(dir):
	if !dTime:
		$DDT.start()
	else:
		dTime = false

	if Input.is_action_just_released("move_sprint"):
		if Input.is_action_just_pressed("move_sprint") and !dTime:
			dir *= dash

	return dir

func sliding(delta):
	var slideDir = Vector3.ZERO
	var xSlope = get_floor_normal().x
	var zSlope = get_floor_normal().z
	var yTilt = abs(get_floor_normal().y)
	print("(x,y,z)")
	print(get_floor_normal())
	if xSlope != 0:
		slideDir.x += (baseAccel*xSlope)/(yTilt+1)*sRate
	if zSlope != 0:
		slideDir.z += (baseAccel*zSlope)/(yTilt+1)*sRate
	print(slideDir)
	return slideDir

func moving(delta):
	var dir = inputs()

	# Gravity
	if !is_on_floor():
		dir.y -= gravity

	if dir == Vector3.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector3.ZERO
	else:
		dir *= baseSpeed*sRate
		if isSprinting:
			dir *= sprintMult
		if velocity.length() < dir.length():
			velocity += dir * delta
		else:
			velocity -= velocity.normalized() * (friction * delta)
	
	if isSliding and velocity.length() < maxSpeed:
		velocity += sliding(delta)
		floor_stop_on_slope = false
		floor_constant_speed = false
	else:
		floor_stop_on_slope = true
		floor_constant_speed = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = Vector3()
	
	moving(delta)
	move_and_slide()

func _on_ddt_timeout():
	dTime = true
