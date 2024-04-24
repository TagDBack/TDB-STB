extends Node3D

var drop_gold = preload("res://scenes/entities/drops/test-drop-currency.tscn")
@export var goldRate = 0.2
@export var maxDrop = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	# var spawnArea = $area.get_shape()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_gold(pos):
	print("spawn gold")
	var rng = RandomNumberGenerator.new()
	
	var numDrops = maxDrop
	while maxDrop > 0:
		var rn = rng.randf_range(0.0, 1.0)
		if rn <= goldRate:
			print("drop gold")
		maxDrop -= 1
		
		var inst = drop_gold.instance()
		inst.position = pos
		self.add_child(inst)

func _on_drop(pos):
	spawn_gold(pos)
