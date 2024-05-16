extends CharacterBody3D

#class_name enemy

@export var health = 10
@export var armor = 0
@export var damage = 5
@export var pushed_back_const = 3

@export var speed = 10
var speedMult = 0.8
var isHunt = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var player = null

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
		#print("die")
		isDead = true
		death.emit()
		
func pushed_back():
	self.position += self.transform.basis.y * pushed_back_const
	self.position += self.transform.basis.z * pushed_back_const

func direction(_delta):
	var dir = Vector3.ZERO
	
	if !is_on_floor():
		dir.y -= gravity
	
	if isHunt:
		dir = hunt(_delta, dir)
		#pass
	
	return dir

func hunt(_delta, dir):
	var target = (player.position - position).normalized()
	if position.distance_to(player.position) > 1:
		target.y = 0
		dir += target * speed * speedMult
	
	return dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player == null:
		scan_player()
	
	velocity = direction(delta)
	look_at(player.position)
	move_and_slide()

func _on_dead_timeout():
	queue_free()

func scan_player():
	player = get_tree().get_nodes_in_group("player")
	if len(player) == 0:
		player = null
	else:
		player = player[0]
		#print(player)
		isHunt = true
