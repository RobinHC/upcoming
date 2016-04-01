// Returns the single-bend airfoil lines.

Function single_bend_lines
  // In: ce, max_camber, chord, thickness, bend_radius, le_coordinates[], max_camber_position, pitch, wing_lc
  // Out: lines[]

  // First let us make the zero-angle shape, then rotate.
  mcx = le_coordinates[0] + max_camber_position * chord;
  // Point(ce++) = { mcx, le_coordinates[0], 0 }; mc = ce;
  apex_center = le_coordinates[1] + max_camber * chord;
  // Point(ce++) = { le_coordinates[0] + max_camber_position * chord, apex_center, 0 }; ac = ce;

  // Bend points.
  bend_center_y = apex_center - bend_radius;
  Point(ce++) = { mcx, bend_center_y, 0, wing_lc };
  bend_center = ce;
  Point(ce++) = { mcx, apex_center + thickness/2, 0, wing_lc };
  at = ce;
  Point(ce++) = { mcx, apex_center - thickness/2, 0, wing_lc };
  ab = ce;
  te_angle = Atan( max_camber / (1-max_camber_position) );
  le_angle = Atan( max_camber / max_camber_position );
  Rotate { { 0, 0, 1 }, { mcx, bend_center_y, 0 }, -te_angle } 
    { Duplicata{ Point{ at,ab }; } }
  ce += 2;
  pts_ap_te[] = {ce, ce-1};
  Rotate { { 0, 0, 1 }, { mcx, bend_center_y, 0 }, le_angle } 
    { Duplicata{ Point{ at,ab }; } }
  ce += 2;
  pts_ap_le[] = {ce, ce-1};
  Characteristic Length { pts_ap_le[], pts_ap_te[] } = wing_lc;

  // Printf("%f, %f",pts_ap_te[0],pts_ap_te[1]);
  // Printf("%f",le_angle);
  // Printf("%f",max_camber);
  // Printf("%f",(1-max_camber_position));

  // le points.
  lex = le_coordinates[0];
  ley = le_coordinates[1];
  Point(ce++) = { lex, ley, 0, wing_lc };
  le = ce;
  pts_le[] = {};
  Point(ce++) = { lex, ley + thickness/2, 0, wing_lc }; pts_le[] += ce;
  Point(ce++) = { lex, ley - thickness/2, 0, wing_lc }; pts_le[] += ce;
  Point(ce++) = { lex - thickness/2, ley, 0, wing_lc }; pts_le[] += ce;
  Rotate { { 0, 0, 1 }, { lex, ley, 0 }, le_angle } 
    { Point{ pts_le[] }; }

  // te points.
  tex = le_coordinates[0] + chord;
  tey = le_coordinates[1];
  Point(ce++) = { tex, tey, 0, wing_lc };
  te = ce;
  pts_te[] = {};
  Point(ce++) = { tex, tey + thickness/2, 0, wing_lc }; pts_te[] += ce;
  Point(ce++) = { tex, tey - thickness/2, 0, wing_lc }; pts_te[] += ce;
  Point(ce++) = { tex + thickness/2, ley, 0, wing_lc }; pts_te[] += ce;
  Rotate { { 0, 0, 1 }, { tex, tey, 0 }, -te_angle } 
    { Point{ pts_te[] }; }


  // Finally, we can define the lines!!!
  lines[] = {};
  // start from bottom le arc, and wrap around
  Circle(ce++) = {pts_le[1], le, pts_le[2]}; lines[] += ce;
  Circle(ce++) = {pts_le[2], le, pts_le[0]}; lines[] += ce;
  Line(ce++) = {pts_le[0], pts_ap_le[1]}; lines[] += ce;
  Circle(ce++) = {pts_ap_le[1], bend_center, at}; lines[] += ce;
  Circle(ce++) = {at, bend_center, pts_ap_te[1]}; lines[] += ce;
  Line(ce++) = {pts_ap_te[1],pts_te[0]}; lines[] += ce;
  Circle(ce++) = {pts_te[0], te, pts_te[2]}; lines[] += ce;
  Circle(ce++) = {pts_te[2], te, pts_te[1]}; lines[] += ce;
  Line(ce++) = {pts_te[1], pts_ap_te[0]}; lines[] += ce;
  Circle(ce++) = {pts_ap_te[0], bend_center, ab}; lines[] += ce;
  Circle(ce++) = {ab, bend_center, pts_ap_le[0]}; lines[] += ce;
  Line(ce++) = {pts_le[1], pts_ap_le[0]}; lines[] += -ce;

  // One little caveat for gmsh when rotating circular segments -- the rotation direction is dependent on the direction of the circular segment (this seems like a bug in Gmsh).
  Rotate { { 0, 0, 1 }, { lex, ley, 0 }, -pitch } 
    { Line{ lines[] }; }
Return





