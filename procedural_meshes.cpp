/* procedural_meshes.cpp */

#include "procedural_meshes.h"

void MeshSimplification::add(int value) {

    count += value;
}

void MeshSimplification::reset() {

    count = 0;
}

int MeshSimplification::get_total() const {

    return count;
}

void MeshSimplification::_bind_methods() {

    ClassDB::bind_method(D_METHOD("add", "value"), &MeshSimplification::add);
    ClassDB::bind_method(D_METHOD("reset"), &MeshSimplification::reset);
    ClassDB::bind_method(D_METHOD("get_total"), &MeshSimplification::get_total);
}

MeshSimplification::MeshSimplification() {
    count = 0;
}