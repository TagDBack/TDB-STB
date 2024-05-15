extends MeshInstance3D

@onready var colShape = $StaticBody3D/CollisionShape3D
@export var chunk_size = 2.0
@export var height_ratio = 1.0
@export var colShape_size_ratio = 0.5
#@export var level = "res://assets/textures/terrain-crater-1.jpg"
#@export var level_img: CompressedTexture2D = CompressedTexture2D.new()
@export var lvlimg: Image = Image.new()

var img = Image.new()
var shape = HeightMapShape3D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	colShape.shape = shape
	mesh.size = Vector2(chunk_size, chunk_size)
	
	#print(level_img.load_path)
	update_terrain(height_ratio, colShape_size_ratio)

func update_terrain(_height_ratio, _colShape_size_ratio):
	material_override.set("shader_param/height_ratio", _height_ratio)
	
	#img.load(level)
	#img = level_img.get_image()
	img = lvlimg
	#print(img.get_format())
	
	if img.is_compressed():
		#print("decompress")
		img.decompress()
		
	img.convert(Image.FORMAT_RF)
	#print(img.get_format())
	
	#print(img.get_width())
	img.resize(img.get_width()*_colShape_size_ratio, img.get_height()*_colShape_size_ratio)
	#print(img.get_width())
	
	#print("DATA")
	var data = img.get_data().to_float32_array()
	for i in range(0, data.size()):
		data[i] *= _height_ratio
		#print(data[i])
	
	shape.map_width = img.get_width()
	shape.map_depth = img.get_height()
	shape.map_data = data
	
	var scale_ratio = chunk_size/float(img.get_width())
	#print("SCALE: ")
	#print(scale_ratio)
	colShape.scale = Vector3(scale_ratio, 1, scale_ratio)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

# source https://www.youtube.com/watch?v=fEG_cnRQ1HI
