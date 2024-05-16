extends Node

class_name Global_Funcs

@onready var noise = FastNoiseLite.new()
@onready var rng = RandomNumberGenerator.new()

var root_node
var main_scene
var player
var camera
var camera_default_rotation

var camera_shake = false
var shake_strength = 0
var shake_speed = 0
var shake_decay = 0
var noise_i = 0

var enemies_left = 0

func _ready():
	rng.randomize()
	noise.seed = rng.randi()
	root_node = get_tree().get_root()
	
	# The main scene node is always last loaded into root after
	# all autoload (in the project settings)
	main_scene = root_node.get_child(root_node.get_child_count()-1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if camera_shake:
		if shake_strength < 0.1:
			camera_shake = false
		else:
			shake_strength = lerp(shake_strength, 0.0, shake_decay * delta)
			#camera.rotation = shake_offset(delta)
			var rotation_offset = shake_offset(delta)
			camera.set_rotation_degrees(rotation_offset)
			

func get_player():
	if player == null:
		player = main_scene.get_node("Player")
		if player == null:
			print("Player not found, Game crashes")
		camera = player.get_node("Util").get_node("Camera3D")
		camera_default_rotation = camera.get_rotation_degrees()
	return player

func get_main_scene():
	return main_scene

func change_main_scene(scene_path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	call_deferred("_deferred_change_main_scene", scene_path)

func _deferred_change_main_scene(scene_path):
	# It is now safe to remove the current scene.
	main_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(scene_path)

	# Instance the new scene.
	main_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(main_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = main_scene

# shake_strength = higher value -> larger deviation from the default rotation
# shake_speed = how quickly the camera shakes
# shake_decay = how fast the shake fades
func shake_camera(strength: float,speed:float, decay: float):
	camera_shake = true
	shake_strength = strength
	shake_speed = speed
	shake_decay = decay

func shake_offset(delta):
	noise_i += delta * shake_speed
	var x = camera_default_rotation.x + noise.get_noise_2d(1, noise_i) * shake_strength
	var y = camera_default_rotation.y + noise.get_noise_2d(10, noise_i) * shake_strength
	var z = camera_default_rotation.z + noise.get_noise_2d(100, noise_i) * shake_strength
	return Vector3(x, y, z)
