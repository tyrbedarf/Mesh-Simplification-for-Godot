extends MeshInstance

var array_quad_vertices = [];
var array_quad_indices = [];

var dictionary_check_quad_vertices = {};

const CUBE_SIZE = 0.5;


func _ready():
	make_cube();


func make_cube():
	array_quad_vertices = [];
	array_quad_indices = [];
	dictionary_check_quad_vertices = {};
	
	var result_mesh = Mesh.new();
	var surface_tool = SurfaceTool.new();
	
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES);
	
	var vert_north_topright = Vector3(-CUBE_SIZE, CUBE_SIZE, CUBE_SIZE);
	var vert_north_topleft = Vector3(CUBE_SIZE, CUBE_SIZE, CUBE_SIZE);
	var vert_north_bottomleft = Vector3(CUBE_SIZE, CUBE_SIZE, -CUBE_SIZE);
	var vert_north_bottomright = Vector3(-CUBE_SIZE, CUBE_SIZE, -CUBE_SIZE);
	
	var vert_south_topright = Vector3(-CUBE_SIZE, -CUBE_SIZE, CUBE_SIZE);
	var vert_south_topleft = Vector3(CUBE_SIZE, -CUBE_SIZE, CUBE_SIZE);
	var vert_south_bottomleft = Vector3(CUBE_SIZE, -CUBE_SIZE, -CUBE_SIZE);
	var vert_south_bottomright = Vector3(-CUBE_SIZE, -CUBE_SIZE, -CUBE_SIZE);
	
	
	# Make the six quads for needed to make a box!
	# ============================================
	# IMPORTANT: You have to input the points in the going either clockwise, or counter clockwise
	# or the add_quad function will not work!
	
	add_quad(vert_south_topright, vert_south_topleft, vert_south_bottomleft, vert_south_bottomright);
	add_quad(vert_north_topright, vert_north_bottomright, vert_north_bottomleft, vert_north_topleft);
	
	add_quad(vert_north_bottomleft, vert_north_bottomright, vert_south_bottomright, vert_south_bottomleft);
	add_quad(vert_north_topleft, vert_south_topleft, vert_south_topright, vert_north_topright);
	
	add_quad(vert_north_topright, vert_south_topright, vert_south_bottomright, vert_north_bottomright);
	add_quad(vert_north_topleft, vert_north_bottomleft, vert_south_bottomleft, vert_south_topleft);
	# ============================================
	
	for vertex in array_quad_vertices:
		surface_tool.add_vertex(vertex);
	for index in array_quad_indices:
		surface_tool.add_index(index);
	
	surface_tool.generate_normals();
	
	result_mesh = surface_tool.commit();
	self.mesh = result_mesh;


func add_quad(point_1, point_2, point_3, point_4):
	
	var vertex_index_one = -1;
	var vertex_index_two = -1;
	var vertex_index_three = -1;
	var vertex_index_four = -1;
	
	vertex_index_one = _add_or_get_vertex_from_array(point_1);
	vertex_index_two = _add_or_get_vertex_from_array(point_2);
	vertex_index_three = _add_or_get_vertex_from_array(point_3);
	vertex_index_four = _add_or_get_vertex_from_array(point_4);
	
	array_quad_indices.append(vertex_index_one)
	array_quad_indices.append(vertex_index_two)
	array_quad_indices.append(vertex_index_three)
	
	array_quad_indices.append(vertex_index_one)
	array_quad_indices.append(vertex_index_three)
	array_quad_indices.append(vertex_index_four)


func _add_or_get_vertex_from_array(vertex):
	if dictionary_check_quad_vertices.has(vertex) == true:
		return dictionary_check_quad_vertices[vertex];
    
	else:
		array_quad_vertices.append(vertex);
		dictionary_check_quad_vertices[vertex] = array_quad_vertices.size()-1;
		return array_quad_vertices.size()-1;
	