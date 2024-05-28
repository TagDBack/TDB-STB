extends Node3D

@export var player: CharacterBody3D

@export var enemy_pack: PackedScene
@export var total_spawn_number: int = 15
@export var total_batch: int = 5
@export var delay_batch_spawn = 1
@export var min_radius = 0
@export var max_radius = 5
@export var origin = Vector3(0, 10, 0)

func _ready():
	randomize()
	scan_player()
	repeat()

func _setup(player):
	self.player = player

func spawn(number_spawn_now):
	call_deferred("_deferred_spawn", number_spawn_now)

func _deferred_spawn(number_spawn_now):
	for i in range(number_spawn_now):
		var spawned = enemy_pack.instantiate()
		
		var spawn_pos = origin
		var angle = randf_range(-2 * PI, 2 * PI)
		var radius = randf_range(min_radius, max_radius)
		
		# Add the spawned node to the scene tree first
		get_parent().get_parent().add_child(spawned)
		spawn_pos.x = spawn_pos.x + radius * cos(angle)
		spawn_pos.z = spawn_pos.z + radius * sin(angle)
		
		spawned.global_position = spawn_pos
		spawned.look_at(origin)
		
		if player != null:
			spawned.player = player
			spawned.isHunt = true

func repeat():
	call_deferred("_deferred_repeat")

func _deferred_repeat():
	if total_batch == 0:
		self.queue_free()
	else:
		var number_spawn_now = floor(total_spawn_number / total_batch)
		spawn(number_spawn_now)
		total_spawn_number = total_spawn_number - number_spawn_now
		total_batch = total_batch - 1
		
		await get_tree().create_timer(delay_batch_spawn).timeout
		repeat()
	
func scan_player():
	var list_player = get_tree().get_nodes_in_group("player")
	if len(list_player) == 0:
		player = null
	else:
		player = list_player[0]
