// Author: Robert Lee
// Email: rlee32@gatech.edu

// All units are metric.
// Geometry follows that described on:
// http://turbmodels.larc.nasa.gov/axiswblim7_val.html

// A structured boundary layer (BL) mesh is made near the surface, 
//  while the rest of the domain is unstructured.

//Inputs

// Geometry
radius = 0.1; // m, radius of main body.
simulated_body_length = 0.55; // m, from start of domain to the flare base.
flare_angle = 20*Pi/180; // rad
flare_length = 0.15; // m, length from flare base to end of domain.
far_field = 5*radius;
// body_length = 1.39; // m, from leading edge (LE) to flare base
// cone_angle = 10*Pi/180; // rad
// fillet_radius = 0.1; // m, fillet between LE cone and main body.

// Grid
cell_length = 0.1*radius; // determines how many cells are along the surface.
bl_height = 0.02;
normal_cells = 10; // number of cells in BL normal to surface.
bl_progression = 1.1; // The geometric increase in cell size in the BL.
far_length = 0.2*radius; // dimension of cells in the far-field boundary.


// Draw Points.

ce = 0;
Point(ce++) = { 0,radius,0 }; body_start = ce;
Point(ce++) = { simulated_body_length, radius, 0 }; flare_base = ce;
Point(ce++) = { simulated_body_length+flare_length*Cos(flare_angle), 
  flare_length*Sin(flare_angle)+radius, 0 }; flare_end = ce;
vertical_difference = far_field - flare_length*Sin(flare_angle);
Point(ce++) = { simulated_body_length+flare_length*Cos(flare_angle) - 
  vertical_difference*Sin(flare_angle), radius+far_field, 0, far_length }; 
  freestream_end = ce; 
Point(ce++) = { 0, radius+far_field, 0, far_length }; freestream_start = ce;

// BL points
Point(ce++) = { 0,radius+bl_height,0, cell_length }; bl_start = ce;
Point(ce++) = { simulated_body_length-Sin(flare_angle/2)*bl_height, 
  radius+Cos(flare_angle/2)*bl_height, 0 }; bl_mid = ce;
Point(ce++) = { simulated_body_length+flare_length*Cos(flare_angle)
    -Sin(flare_angle)*bl_height, 
  flare_length*Sin(flare_angle)+radius+Cos(flare_angle)*bl_height, 
  0, cell_length }; 
  bl_end = ce;

// Draw lines.

Line(ce++) = { body_start, flare_base }; body = ce;
Line(ce++) = { flare_base, flare_end }; flare = ce;
Line(ce++) = { flare_end, bl_end }; bl3 = ce;
Line(ce++) = { bl_end, freestream_end }; outlet = ce;
Line(ce++) = { freestream_end, freestream_start }; top = ce;
Line(ce++) = { freestream_start, bl_start }; inlet = ce;
Line(ce++) = { bl_start, body_start }; bl1 = ce;
Line(ce++) = { bl_start, bl_mid }; bl_top1 = ce;
Line(ce++) = { bl_mid, bl_end }; bl_top2 = ce;
Line(ce++) = { flare_base, bl_mid }; bl2 = ce;

// Loops

Line Loop(ce++) = { bl1, body, bl2, -bl_top1 }; bl_loop1 = ce;
Line Loop(ce++) = { -bl2, flare, bl3, -bl_top2 }; bl_loop2 = ce;
Line Loop(ce++) = { bl_top1, bl_top2, outlet, top, inlet }; far = ce;

// Surfaces

Plane Surface(ce++) = { far }; external = ce;
Plane Surface(ce++) = { bl_loop1 }; bl_surf1 = ce;
Plane Surface(ce++) = { bl_loop2 }; bl_surf2 = ce;

// Set structured grid parameters.

Transfinite Line{ -bl1, bl2 , bl3 } = normal_cells Using Progression bl_progression;
Transfinite Line{ bl_top1, body } = simulated_body_length / cell_length;
Transfinite Line{ bl_top2, flare } = flare_length / cell_length;

Transfinite Surface{ bl_surf1, bl_surf2 };
Recombine Surface{ bl_surf1, bl_surf2 };


// Make 3D wedge.

Rotate {{1,0,0},{0,0,0},2.5*Pi/180.0}
{
 Surface{external, bl_surf1, bl_surf2};
}
new_entities[] = Extrude {{1,0,0},{0,0,0},-5*Pi/180.0}
{
 Surface{external, bl_surf1, bl_surf2};
 Layers{1};
 Recombine;
};

// Define names of physical surfaces.

Physical Surface("freestream") = {new_entities[{6,9}]};
Physical Surface("top") = {new_entities[{5}]};
Physical Surface("outlet") = {new_entities[{4,17}]};
// Physical Surface("inlet") = {new_entities[4]};
Physical Surface("wedge0") = {bl_surf2, bl_surf1, external};
Physical Surface("wedge1") = {new_entities[{0,7,13}]};
Physical Surface("missile") = {new_entities[{10,16}]};

Physical Volume("volume") = {new_entities[{1,8,14}]};


