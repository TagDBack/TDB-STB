extends CharacterBody3D

class_name enemy

@export var health = 10
@export var armor = 0
@export var damage = 5

@export var speed = 10
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var player = get_tree().get_nodes_in_group("player")[0]

var isDead = false

@export var expDrop = 10

signal death()
signal drop()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")

func take_damage(damage):
	#print("dmg")
	var damageTaken = damage - armor
	health -= damageTaken
	if health <= 0:
		drop.emit(global_position)
		$dead.start()
		print("die")
		isDead = true
		death.emit()

func direction(_delta):
	var dir = Vector3.ZERO
	
	if !is_on_floor():
		dir.y -= gravity
		
	if player != null:
		dir = hunt(_delta, dir)
	
	return dir

func hunt(_delta, dir):
	var target = (player.position - position).normalized()
	if position.distance_to(player.position) > 1:
		target.y = 0
		dir += target * speed
	
	return dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = direction(delta)
	move_and_slide()

func _on_dead_timeout():
	queue_free()
