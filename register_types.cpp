/* register_types.cpp */

#include "register_types.h"
#include "core/class_db.h"
#include "procedural_meshes.h"

void register_mesh_simplification_for_godot_types() {

        ClassDB::register_class<MeshSimplification>();
}

void unregister_mesh_simplification_for_godot_types() {
   //nothing to do here
}