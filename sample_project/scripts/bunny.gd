extends MeshInstance

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var proc_mesh = ProceduralMesh.new()
	var faces = mesh.get_faces()
	var i = 0;
	while (i < faces.size()):
		proc_mesh.add_triangle(faces[i + 0], faces[i + 1], faces[i + 2])
		i = i + 3
	
	proc_mesh.simplify_mesh(1000, 7, true)
	# proc_mesh.simplify_mesh_lossless(true)
	var result = proc_mesh.get_surface()
	result.generate_normals(false)
	result.index()
	
	var mesh = result.commit()
	self.mesh = mesh
	
	print("Faces: " + str(mesh.get_faces().size()))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
