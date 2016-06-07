// Author: Robert Lee
// Email: rlee32@gatech.edu

// All units are metric.
// Geometry follows that described on:
// http://turbmodels.larc.nasa.gov/axiswblim7_val.html

// A structured boundary layer (BL) mesh is made near the surface, 
//  while the rest of the domain is unstructured.

//Inputs

// Geometry
radius = 0.1; // m
body_length = 1.39; // m, from leading edge to flare base
flare = 20*Pi/180; // rad
far_field = 10*radius;

// Grid
cell_length = 0.1*radius; // determines how many cells are along the surface.
bl_height = 0.02;
normal_cells = 20; // number of cells in BL normal to surface.
bl_progression = 1.1; // The geometric increase in cell size in the BL.

normal_cells = 20;
axis_cells = 100;
samples = 100; // points to use in BSpline of nozzle wall.
// Constants
itm = 0.0254; // inch to meter.
i2tm2 = itm*itm; // in^2 to m^2

// Subroutines

// Takes a position and gives the area according to the prescribed geometry.
// Input: x 
// Output: a
Function area
  If ( x < 5.0*itm )
    a = i2tm2 * ( 1.75 - 0.75 * Cos( ( 0.2 * x / itm - 1.0 ) * Pi ) );
  Else
    a = i2tm2 * ( 1.25 - 0.25 * Cos( ( 0.2 * x / itm - 1.0 ) * Pi ) );
  EndIf
Return

// Takes a position and computes the corresponding radius.
// Input: x
// Output: r
Function radius
  Call area;
  r = Sqrt( a / Pi );
Return

// Draw Points.

ce = 0;
Point(ce++) = { 0, 0, 0 }; axis_start = ce;
Point(ce++) = { 10*itm, 0, 0 }; axis_end = ce;
x = 0;
Call radius;
Point(ce++) = { x, r, 0 }; wall_start = ce;
x = 10*itm;
Call radius;
Point(ce++) = { x, r, 0 }; wall_end = ce;
wall_points[] = {};
For k In {1:samples-2}
  x = k * 10*itm / (samples-1);
  Call radius;
  Point(ce++) = { x, r, 0 };
  wall_points[] += ce;
EndFor

// Draw Lines.

BSpline(ce++) = { wall_start, wall_points[], wall_end }; wall = ce;
Line(ce++) = {axis_start, axis_end}; axis = ce;
Line(ce++) = {axis_start, wall_start}; inlet = ce;
Line(ce++) = {axis_end, wall_end}; outlet = ce;

// Make surfaces.

Line Loop(ce++) = { axis, outlet, -wall, -inlet };
loop = ce;
Plane Surface(ce++) = loop; surf = ce;

// Specify structured meshing.

Transfinite Line{ wall, axis } = axis_cells;
Transfinite Line{ inlet, outlet } = normal_cells;
Transfinite Surface{ surf };
Recombine Surface{ surf };

// Make 3D wedge.

Rotate {{1,0,0},{0,0,0},2.5*Pi/180.0}
{
 Surface{surf};
}
new_entities[] = Extrude {{1,0,0},{0,0,0},-5*Pi/180.0}
{
 Surface{surf};
 Layers{1};
 Recombine;
};

// Define names of physical surfaces.

Physical Surface("nozzle") = {new_entities[{3}]};
Physical Surface("outlet") = {new_entities[2]};
Physical Surface("inlet") = {new_entities[4]};
Physical Surface("wedge0") = {surf};
Physical Surface("wedge1") = {new_entities[0]};

Physical Volume("volume") = {new_entities[1]};



