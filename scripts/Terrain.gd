tool
extends MeshInstance

var width = 64+1
var length = 64+1
var widthCells = width - 1
var lengthCells = length - 1
var offsetX = width*0.5
var offsetZ = length*0.5

func _ready():
	
	var heightmap = RandomDiamondSquare()
	# Create the grid and add the y values, for now keep them at 0
	var st = SurfaceTool.new()
	var mesh = Mesh.new()
	randomize()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	#Material ground = Material.new()
	#Create the vertices
	for z in range(0,length):
		for x in range(0,width):
			#st.set_material("res://clover.jpg")
			st.add_color(Color(0, x, 0))
			st.add_uv(Vector2(0, 0))
			st.add_vertex(Vector3(x-offsetX, 0, z-offsetZ))
			#st.add_vertex(Vector3((x-offsetX)*0.5,0,(z-offsetZ)*0.5))
	
	#Create the indices for each quad in the grid
	for row in range(0,lengthCells):
		for column in range(0,widthCells):
			var lowerLeftCorner = column + (row*length)
			var lowerRightCorner = lowerLeftCorner + 1
			var upperLeftCorner = lowerLeftCorner + length
			var upperRightCorner = upperLeftCorner + 1
		
			#|/
			st.add_index(lowerLeftCorner)
			st.add_index(upperLeftCorner)
			st.add_index(upperRightCorner)
			#/|
			st.add_index(lowerLeftCorner)
			st.add_index(upperRightCorner)
			st.add_index(lowerRightCorner)
	
	st.generate_normals()
	st.commit(mesh)
	self.set_mesh(mesh)
	pass

func RandomDiamondSquare():
	var heightmap = []
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass