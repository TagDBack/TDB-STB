extends MeshInstance3D

@onready var colShape = $StaticBody3D/CollisionShape3D
@export var chunk_size = 2.0
@export var height_ratio = 1.0
@export var colShape_size_ratio = 0.5
#@export var level = "res://assets/textures/terrain-crater-1.jpg"
@export var texture: CompressedTexture2D
#@export var lvlimg: Image = Image.new()

#var img = Image.new()
var shape = HeightMapShape3D.new()
var lvlimg: Image

# Called when the node enters the scene tree for the first time.
func _ready():
	#colShape.shape = shape
	#mesh.size = Vector2(chunk_size, chunk_size)
	#
	#print(level_img.load_path)
	#update_terrain(height_ratio, colShape_size_ratio)
	if texture:
		print("Starting to load and process the image asynchronously.")
		await load_and_process_image()

# Asynchronously load and process the image
func load_and_process_image() -> void:
	await get_tree().process_frame  # Wait for the next frame
	lvlimg = texture.get_image()
	if lvlimg:
		await get_tree().process_frame
		update_terrain()
	else:
		print("Failed to convert texture to image.")

func update_terrain():
	if not lvlimg:
		print("Error: Image not loaded.")
		return
	
	if lvlimg.is_compressed():
		lvlimg.decompress()
	
	lvlimg.convert(Image.FORMAT_RF)
	lvlimg.resize(lvlimg.get_width() * colShape_size_ratio, lvlimg.get_height() * colShape_size_ratio)
	
	var data = lvlimg.get_data().to_float32_array()
	var data_size = data.size()
	for i in range(data_size):
		data[i] *= height_ratio
	
	shape.map_width = lvlimg.get_width()
	shape.map_depth = lvlimg.get_height()
	shape.map_data = data
	
	var scale_ratio = chunk_size / float(lvlimg.get_width())
	colShape.scale = Vector3(scale_ratio, 1, scale_ratio)
	
	colShape.shape = shape
	mesh.size = Vector2(chunk_size, chunk_size)
	
	print("Image processing complete.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

# source https://www.youtube.com/watch?v=fEG_cnRQ1HI
