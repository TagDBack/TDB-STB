extends Node3D

@export var enemy_pack: PackedScene
@export var total_spawn_number: int = 100
@export var total_batch: int = 5
@export var delay_batch_spawn = 5
@export var min_radius = 0
@export var max_radius = 5
@export var origin = Vector3(0, 0, 0)

func _ready():
	randomize()
	repeat()

func spawn(number_spawn_now):
	print("spawn")
	call_deferred("_deferred_spawn", number_spawn_now)

func _deferred_spawn(number_spawn_now):
	for i in range(number_spawn_now):
		var spawned = enemy_pack.instantiate()
		get_parent().get_parent().add_child(spawned)
		
		var spawn_pos = origin
		var angle = randf_range(-2 * PI, 2 * PI)
		
		spawn_pos.x = spawn_pos.x + randf_range(min_radius, max_radius) * cos(angle)
		spawn_pos.z = spawn_pos.z + randf_range(min_radius, max_radius) * sin(angle)
		
		spawned.global_position = spawn_pos
		spawned.look_at(origin)

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
