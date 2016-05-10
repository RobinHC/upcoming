Include "single_bend_lines.geo";

// Wing
ce = 0;
max_camber = 0.1; 
chord = 0.5; 
thickness = 3/8*0.0254;
bend_radius = (1.445/2+3/8/2)*0.0254;
le_coordinates[] = {0,0};
max_camber_position = 0.25;
pitch = 10*Pi/180;

// default surface grid
wing_lc = chord / 100;
// boundary-layer-type grid
fine_lc = chord / 400;
fine_dist = 0.7*thickness;
// near-region grid.
near_wing_lc = chord / 100;
near_wing_dist = chord / 15;
// distance to reach max lc.
far_wing_dist = 2*chord;

// Far field
forward_distance = chord * 10;
aft_distance = chord * 20;
far_lc = forward_distance / 20;


// Wing
Call single_bend_lines;

Line Loop(ce++) = lines[]; wing_loop = ce;

// Far field
pts[] = {};
Point(ce++) = { -forward_distance, forward_distance, 0, far_lc}; pts[] += ce;
Point(ce++) = { aft_distance, forward_distance, 0, far_lc}; pts[] += ce;
Point(ce++) = { aft_distance, -forward_distance, 0, far_lc}; pts[] += ce;
Point(ce++) = { -forward_distance, -forward_distance, 0, far_lc}; pts[] += ce;

lns[] = {};
Line(ce++) = {pts[0],pts[1]}; lns[] += ce;
Line(ce++) = {pts[1],pts[2]}; lns[] += ce;
Line(ce++) = {pts[2],pts[3]}; lns[] += ce;
Line(ce++) = {pts[3],pts[0]}; lns[] += ce;

Line Loop(ce++) = {lns[]};
Plane Surface(ce++) = {ce-1, wing_loop}; surf2d = ce;

Mesh.CharacteristicLengthExtendFromBoundary = 0;


top_and_curve[] = lines[{0:7}];
all_wing_lines[] = lines[];

// Boundary layer - type grid
Field[1] = Attractor;
Field[1].EdgesList = {top_and_curve[]};
Field[1].NNodesByEdge = 200;
Field[2] = Threshold;
Field[2].IField = 1;
Field[2].LcMin = fine_lc;
Field[2].LcMax = fine_lc;
Field[2].DistMin = fine_dist;
Field[2].DistMax = fine_dist;
Field[2].StopAtDistMax = 1;

// Near-wing
Field[3] = Attractor;
Field[3].EdgesList = {all_wing_lines[]};
Field[3].NNodesByEdge = 200;
Field[4] = Threshold;
Field[4].IField = 3;
Field[4].LcMin = near_wing_lc;
Field[4].LcMax = far_lc;
Field[4].DistMin = near_wing_dist;
Field[4].DistMax = far_wing_dist;

// Final field
Field[5] = Min;
Field[5].FieldsList = {2,4}; // DO NOT INCLUDE ATTRACTORS!!!
Background Field = 5;

// // Automatic levels.
// start_lines[] = lines[{0:7}];
// grid_levels[] = {chord/400, chord/200, chord/50};
// dist_levels[] = {thickness/2, chord/50, chord/10};
// For k In {1:#grid_levels[]}
//   // Printf("%f\n",grid_levels[k-1]);
//   // Attractor
//   Field[2*k-1] = Attractor;
//   Field[2*k-1].EdgesList = {start_lines[]};
//   Field[2*k-1].NNodesByEdge = 200;
//   // Threshold
//   Field[2*k] = Threshold;
//   Field[2*k].IField = 2*k-1;
//   Field[2*k].LcMin = grid_levels[k-1];
//   Field[2*k].LcMax = grid_levels[k-1];
//   Field[2*k].DistMin = dist_levels[k-1];
//   Field[2*k].DistMax = dist_levels[k-1];
//   Field[2*k].StopAtDistMax = 1;
// EndFor
// Field[2*#grid_levels[]+1] = Min;
// Field[2*#grid_levels[]+1].FieldsList = {2:2:2*#grid_levels[]}; // DO NOT INCLUDE ATTRACTORS!!!
// Background Field = 2*#grid_levels[]+1;

new_entities[] = 
Extrude{0,0,0.01}
{
  Surface{surf2d};
  Layers{1};
  Recombine;
};

Physical Surface("wing") = {new_entities[{6:17}]};
Physical Surface("inlet") = {new_entities[{5}]};
Physical Surface("tunnel") = {new_entities[{2,4}]};
Physical Surface("outlet") = {new_entities[{3}]};
Physical Surface("front_and_back") = {surf2d,new_entities[0]};

Physical Volume("volume") = {new_entities[1]};




