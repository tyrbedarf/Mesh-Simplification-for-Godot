/*
* Adopted from https://github.com/sp4cerat/Fast-Quadric-Mesh-Simplification
*
* Mesh Simplification (C)2014 by Sven Forstmann in 2014, MIT License
*
*/
#ifndef SIMPLIFY_H
#define SIMPLIFY_H

#include <math.h>
#include <vector>
#include <map>

#include "core/os/os.h"
#include "core/math/vector3.h"
#include "core/reference.h"
#include "scene/resources/surface_tool.h"
#include "scene/resources/material.h"
#include "scene/resources/mesh.h"
#include "scene/3d/mesh_instance.h"
#include "scene/resources/mesh.h"
#include "scene/resources/mesh_library.h"
#include "scene/3d/visual_instance.h"
#include "scene/main/node.h"
#include "core/vector.h"

#include "symetric_matrix.h"


enum Attributes {
	NONE,
	NORMAL = 2,
	TEXCOORD = 4,
	COLOR = 8
};

struct Triangle
{
	int v[3];
	double err[4];
	int deleted;
	int dirty;
	Vector3 n;
	Vector3 uvs[3];
	int attr;
};

struct Vertex
{
	Vector3 p;
	int tstart;
	int tcount;
	SymetricMatrix q;
	int border;
};

struct VTRef
{
	int tid;
	int tvertex;
};

class ProceduralMesh : public Reference {
	GDCLASS(ProceduralMesh, Reference)

public:
	void add_triangle(Vector3 a, Vector3 b, Vector3 c);
	Ref<SurfaceTool> get_surface();

	//
	// Main simplification function
	//
	// target_count  : target nr. of triangles
	// agressiveness : sharpness to increase the threshold.
	//                 5..8 are good numbers
	//                 more iterations yield higher quality
	//
	void simplify_mesh(int target_count, double agressiveness = 7, bool verbose = false);
	void simplify_mesh_lossless(bool verbose = false);

protected:
	static void _bind_methods();

private:
	std::vector<Triangle> triangles;
	std::vector<Vertex> vertices;
	std::vector<VTRef> refs;

	std::map<Vector3, size_t> vertex_indices;

	size_t get_index(Vector3 v);

	// Check if a triangle flips when this edge is removed
	bool flipped(Vector3 p, int i0, int i1, Vertex &v0, Vertex &v1, std::vector<int> &deleted);

	void update_uvs(int i0, const Vertex &v, const Vector3 &p, std::vector<int> &deleted);

	// Update triangle connections and edge error after a edge is collapsed
	void update_triangles(int i0, Vertex &v, std::vector<int> &deleted, int &deleted_triangles);

	// compact triangles, compute edge error and build reference list
	void update_mesh(int iteration);

	// Finally compact mesh before exiting
	void compact_mesh();

	// Error between vertex and Quadric
	double vertex_error(SymetricMatrix q, double x, double y, double z);

	// Error for one edge
	double calculate_error(int id_v1, int id_v2, Vector3 &p_result);

};
#endif // !SIMPLIFY_H
