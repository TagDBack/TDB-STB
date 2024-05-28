extends CharacterBody3D

var isLookMouse = false

# Movement
var baseSpeed = 10
@export var sRate = 1.0
@export var sprintMult = 1.5
var isSprinting = false
var friction = 20

# Dash 
var dTime = false
var dash = 30
@onready var dashtimer = $DashCooldown

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
	# Player only
	max_slides = 18
	add_to_group("player")
	
	#call_deferred_thread_group("enemies")


func inputs():
	var dir = Vector3.ZERO
	
	# Normal Movement
	dir.z = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	dir.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))

	dir.normalized()

	# Sprinting
	isSprinting = Input.is_action_pressed("move_sprint")
	if Input.is_action_pressed("move_sprint"):
		# Dash mechanic?
		dir = dashing(dir)

	# Sliding
	isSliding = Input.is_action_pressed("move_slide")
	
	if Input.is_action_just_pressed("action_toggle_view"):
		isLookMouse = not(isLookMouse)
		#print(isLookMouse)

	return dir

func dashing(dir):
	if Input.is_action_just_pressed("move_dash") and not(dTime):
		var dashVec = dir.normalized() * dash
		print(dashVec)
		
		dir += dashVec
		dTime = true
		dashtimer.start()
	
	return dir

func sliding(delta):
	var slideDir = Vector3.ZERO
	var xSlope = get_floor_normal().x
	var zSlope = get_floor_normal().z
	var yTilt = abs(get_floor_normal().y)
	#print("(x,y,z)")
	#print(get_floor_normal())
	if xSlope != 0:
		slideDir.x += (baseAccel*xSlope)/(yTilt+1)*sRate
	if zSlope != 0:
		slideDir.z += (baseAccel*zSlope)/(yTilt+1)*sRate
	#print(slideDir)
	return slideDir

func moving(delta):
	var dir = inputs()
	
	if dir == Vector3.ZERO or dir == null:
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
	if isLookMouse:
		var mouse_position = get_viewport().get_mouse_position()
		var target_position = self.to_local(Vector3(mouse_position.x, 0, mouse_position.y))
		$Entity.look_at(target_position, Vector3.UP)
	elif velocity.length_squared() > 0:
		$Entity.look_at(velocity, Vector3.UP)
	
	if velocity.length() > baseSpeed * sRate / 2:
		$pointer.visible = true
		$pointer.look_at(velocity, Vector3.UP)
	else:
		$pointer.visible = false

	# Gravity
	if !is_on_floor():
		velocity.y -= gravity
		
	moving(delta)
	move_and_slide()

func _on_ddt_timeout():
	dTime = false
