extends RigidBody3D

@export var health = 10
@export var armor = 0
@export var speed = 10
@export var damage = 5

var isDead = false

@export var expDrop = 10

signal death(expDrop)
signal drop()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_damage(damage):
	#print("dmg")
	var damageTaken = damage - armor
	health -= damageTaken
	if health <= 0:
		drop.emit(global_position)
		$dead.start()
		print("die")
		isDead = true
		death.emit(expDrop)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if Input.is_action_just_pressed("action_melee"):
		##print("dmg")
		#take_damage(5)

func _on_dead_timeout():
	queue_free()
