extends CharacterBody3D

var baseSpeed = 10
@export var sRate = 1.0
@export var sprintMult = 1.5

var dTime = false
var dash = 100

var isSliding = false
var slideS = 50
var friction = 0.8

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var health = 100

var damage = 10
@export var dmMult = 1.0
@export var dnRate = 1.0

@export var size = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func inputs():
	var dir = Vector3.ZERO
	var speed = baseSpeed
	
	# Gravity
	if !is_on_floor():
		dir.y -= gravity
	
	# Sprinting
	if Input.is_action_pressed("move_sprint"): #X
		speed *= sprintMult
	
	# Dash mechanic?
	if Input.is_action_just_pressed("move_sprint"):
		if !dTime:
			$DDT.start()
		else:
			dTime = false

	if Input.is_action_just_released("move_sprint"):
		if Input.is_action_just_pressed("move_sprint") and !dTime:
			pass

	# Normal Movement
	if Input.is_action_pressed("move_up"): #Z
		dir.z -= speed
	if Input.is_action_pressed("move_down"): #Z
		dir.z += speed
	
	if Input.is_action_pressed("move_left"): #X
		dir.x -= speed
	if Input.is_action_pressed("move_right"): #X
		dir.x += speed
	
	dir.normalized()
	
	# Sliding
	isSliding = Input.is_action_pressed("move_slide")
	if isSliding:
		dir = sliding(dir)
	
	return dir

func sliding(dir):
	return dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = Vector3()
	
	dir = inputs()
	
	velocity = dir
	
	move_and_slide()


func _on_ddt_timeout():
	dTime = true
