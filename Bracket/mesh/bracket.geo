itm = 0.0254; // for 'a * itm = b', where a is in inches, b in meters.

thickness = 0.125 * itm;
free_length = 1.5 * itm;
fixed_length = 1.5 * itm;
bracket_width = 1 * itm;
fillet_radius = thickness;

load = 150; // N, used just for calculating traction required on bracket end.
density = 2700; // kg / m^3, used just for output calculations.

fine_grid_size = 0.02 * thickness;
coarse_grid_size = 0.1 * thickness;

ce = 0;

Point(ce++) = {0,0,0,coarse_grid_size}; fixed_corner = ce;
Point(ce++) = {-thickness-fillet_radius,0,0,fine_grid_size}; fixed_top = ce;
Point(ce++) = {-free_length,0,0,coarse_grid_size}; free_top = ce;
Point(ce++) = {-free_length,-thickness,0,coarse_grid_size}; free_bottom = ce;
Point(ce++) = {-thickness-fillet_radius,-thickness,0,fine_grid_size}; fillet_top = ce;
Point(ce++) = {-thickness,-thickness-fillet_radius,0,fine_grid_size}; fillet_bottom = ce;
Point(ce++) = {-thickness-fillet_radius,-thickness-fillet_radius,0,fine_grid_size}; 
  fillet_center = ce;
Point(ce++) = {0,-fixed_length,0,coarse_grid_size}; fixed_bottom_right = ce;
Point(ce++) = {-thickness,-fixed_length,0,coarse_grid_size}; fixed_bottom_left = ce;

lns[]={};
Line(ce++) = {fixed_corner, fixed_top};lns[]+=ce;
Line(ce++) = {fixed_top, free_top};lns[]+=ce;
Line(ce++) = {free_top, free_bottom};lns[]+=ce;
Line(ce++) = {free_bottom, fillet_top};lns[]+=ce;
Circle(ce++) = {fillet_top, fillet_center, fillet_bottom};lns[]+=ce;
Line(ce++) = {fillet_bottom, fixed_bottom_left};lns[]+=ce;
Line(ce++) = {fixed_bottom_left, fixed_bottom_right};lns[]+=ce;
Line(ce++) = {fixed_bottom_right, fixed_corner};lns[]+=ce;

Line Loop(ce++) = lns[];
loop = ce;

Plane Surface(ce++) = loop; surf = ce;

ids[] = Extrude{0,0,bracket_width}
{
  Surface{surf};
  Recombine;
  Layers{1};
};

Physical Surface("fixedSurface") = {ids[9]};
Physical Surface("freeSurface") = {ids[{2,3,5:8}]};
Physical Surface("frontAndBack") = {surf,ids[0]};
Physical Surface("loadSurface") = {ids[4]};
Physical Volume("volume") = {ids[1]};

tip_area = bracket_width * thickness;
free_leg_volume = tip_area * (free_length - thickness);
fixed_leg_volume = tip_area * (fixed_length - thickness);
corner_volume = tip_area * thickness;
bracket_volume = free_leg_volume + fixed_leg_volume + corner_volume; 
Printf("Approx. Bracket Weight: %f g", 1e3 * density * bracket_volume);
Printf("Load Surface Area: %e sq. m.", tip_area);
I = ( bracket_width * thickness^3 ) / 12;
Printf("Leg Area Moment of Intertia: %e sq. m.", I);
Printf("Tip Load Traction: %e N/m^2", load / tip_area );
L = free_length - thickness - fillet_radius;
Printf("Cantilever Distance: %e m", L );
M = L * load;
y = thickness / 2;
sigma = M * y / I;
Printf("Analytical Max Stress at Cantilever Distance: %f MPa", sigma / 1e6 );
