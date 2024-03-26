extends Node3D

@export var enemy_pack: PackedScene
@export var min_radius = 0
@export var max_radius = 5
@export var origin = Vector3(0, 0, 0)
@export var delay_spawn = 0.5

func _ready():
	repeat()

func spawn():
	print("spawn")
	var spawned = enemy_pack.instantiate()
	get_parent().get_parent().add_child(spawned)

	var spawn_pos = origin
	var angle = randf_range(-2 * PI, 2 * PI)
	
	spawn_pos.x = spawn_pos.x + randf_range(min_radius, max_radius) * cos(angle)
	spawn_pos.z = spawn_pos.z + randf_range(min_radius, max_radius) * sin(angle)

	spawned.global_position = spawn_pos
	spawned.look_at(origin)

func repeat():
	spawn()
	await get_tree().create_timer(delay_spawn).timeout
	repeat()
