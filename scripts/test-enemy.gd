extends RigidBody3D

@export var health = 10
@export var armor = 0
@export var speed = 10
@export var damage = 5

var isDead = false

@export var expDrop = 10
@export var goldRate = 0.01

signal death

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_damage(damage):
	var damageTaken = damage - armor
	health -= damageTaken
	if health <= 0:
		isDead = true
		death.emit(expDrop)

func drop_gold():
	var rng
	
	if rng <= goldRate:
		pass #drop gold

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_dead_timeout():
	pass # remove self
