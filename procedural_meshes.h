/* procedural_meshes.h */
#ifndef MESH_SIMPLIFICATION_FOR_GODOT_H
#define MESH_SIMPLIFICATION_FOR_GODOT_H

#include "core/reference.h"

class MeshSimplification : public Reference {
    GDCLASS(MeshSimplification, Reference);

    int count;

protected:
    static void _bind_methods();

public:
    void add(int value);
    void reset();
    int get_total() const;

    MeshSimplification();
};

#endif