// KINGrinder K6 replica (straight handle version). z = 0 is the bottom of the lower metal body's pad (assumed).
//
// SOURCES
//  - 6.35mm (1/4") hex shaft: CAD hex circumradius 3.67mm.
//  - Handle: ESTIMATED from the manual photo proportions + 6.5mm rod seen in Printables 1295840 STEP.
//    No published handle dims found -- measure the real one and update the handle variables.
$fn = 96;

grinder_view = "exploded";                // [exploded:Exploded, assembled:Assembled, assembled_cut_in_half:Assembled and cut in half]
show_handle = true;
show_grinder_preview = true;              // other files that include this one set this to false to use only the modules and variables

// ---------- body, bottom to top ----------
body_total_height = 175.5;                  // measured by hand, with the plastic cap

// ---------- lower metal body, bottom to top ----------
lower_body_top_recess_height = 10.5;        // measured by hand, the more recessed part at the top of the lower middle body
lower_body_top_recess_diameter = 46.5;      // measured by hand, diameter of that recessed part
// lower_body_main_diameter is derived below the upper body variables (same diameter as the upper middle body)
lower_body_top_recess_wall_thickness = 2;   // measured by hand, chosen over an earlier 2.2 reading because it matches the measured 42.5 bore. Source of truth for the bore diameter
lower_body_bore_diameter = lower_body_top_recess_diameter - 2 * lower_body_top_recess_wall_thickness;   // 42.5, derived: the lower body is completely hollow, a perfect cylinder cut out from the top. Matches the 42.5 measured by hand
lower_body_bore_depth = 66;                 // measured by hand, from the top of the lower body down to the floor of the bore, NOT all the way through
lower_body_bottom_pad_diameter = 46;        // measured by hand
lower_body_total_height = 68.5;            // measured by hand, accurate. The whole lower metal body unscrewed from the rest: includes the bottom pad and the recessed top part
lower_body_bottom_pad_height = 0.4;         // measured by hand (about), padding at the very bottom, sticks out below the metal
lower_body_metal_height = lower_body_total_height - lower_body_bottom_pad_height;   // 68.1, derived: metal only, without the pad
lower_body_main_height = lower_body_metal_height - lower_body_top_recess_height;   // 57.6, derived: full diameter section, below the recessed top part

// ---------- top recess ----------
upper_body_hopper_wall_thickness = 4.4;           // measured by hand, wall around the recess at the top, source of truth for the hopper diameter
upper_body_hopper_depth = 12.5;                   // measured by hand (about), depth of the lid recess at the top. NOTE: the hopper is still NOT an accurate representation of the real one (plain bore)


// ---------- lid (one piece: outer ring, flat top plate, inner ring; the gasket is separate) ----------
lid_outer_ring_diameter = 54.6;               // measured by hand, widest part of the grinder
lid_outer_ring_thickness = 3.6;               // measured by hand, ring showing on the outer edge at the very top
lid_inner_ring_diameter = 45.2;               // measured by hand, the inner part of the lid that goes down into the grinder
lid_total_height = 8.6;                       // measured by hand, outer ring plus inner ring
lid_inner_ring_height = lid_total_height - lid_outer_ring_thickness;   // 5.0, how far the inner ring extends below the outer ring
lid_center_cutout_diameter = 13.5;            // measured by hand, the lower part of the handle socket passes through this
lid_center_recess_width = 1.2;                // measured by hand (approx), width of the step around the center cutout
lid_center_recess_depth = 0.3;                // measured by hand (approx), how far the step drops below the flat top
lid_gasket_height = 1.6;                     // measured by hand, centered vertically on the inner ring
lid_gasket_embed_depth = 1.0;                 // measured by hand (approx), how far the round gasket sinks into the inner ring
lid_gasket_protrusion = lid_gasket_height - lid_gasket_embed_depth;   // 0.6, how far the gasket sticks out past the inner ring

// ---------- top body (ONE piece: a lower section, and the clicking adjuster section at the top of the same part) ----------
upper_body_total_height = 114;              // measured by hand with the clicker fully extended, metal part only, no lid
upper_body_clicker_height = 30.5;          // measured by hand, the twist-and-click grind setting part, counted down from the top of the top body
upper_body_lower_height = upper_body_total_height - upper_body_clicker_height;   // 82.5, the lower section below the clicking section
upper_body_lower_diameter = 52;          // measured by hand, the rest of the top body below the adjuster
upper_body_clicker_diameter = 54.6;       // measured by hand, the clicking circle
upper_body_clicker_bottom_chamfer_height = 2;                // measured by hand (about), how far the shallow chamfer at the bottom of the clicker extends up along the axis
upper_body_clicker_bottom_chamfer_diameter_reduction = 0.4;  // ESTIMATE: "maybe like .4", the diameter at the very bottom of the chamfer is this much smaller than the clicker diameter (0.2 per side). Very shallow angle, error range maybe 0.2 to 0.8
lower_body_main_diameter = upper_body_lower_diameter;   // 52, derived: the main section of the lower body has the same diameter as the lower section of the upper body
upper_body_hopper_diameter = upper_body_clicker_diameter - 2 * upper_body_hopper_wall_thickness;   // 45.8, derived: recess at the top for the lid, from the clicker diameter and the measured wall
// zones of the lower section, bottom to top. Same part, just different looking bands.
upper_body_gap_clicker_to_grip_band = 6;           // measured by hand (about), clicker fully extended, narrow metal band between the clicking section and the grip band (the one with the small index marks)
upper_body_grip_band_diameter = 52.3;       // measured by hand (about), the black grip band sticks out past the 52 mm metal
upper_body_grip_band_height = 62.5;          // measured by hand (about), clicker fully extended, black rubber grip band
upper_body_gap_grip_band_to_bottom = 15.5;   // measured by hand (about), metal ring at the very bottom, between the grip band and the bottom edge
upper_body_cavity_depth = 11;            // measured by hand, depth of the grounds cavity cut into the bottom of the upper body
upper_body_cavity_diameter = 47;            // measured by hand (about), inside diameter of the cavity
upper_body_cavity_wall_thickness = 2.7;     // measured by hand. NOTE: the real wall is thinner than this because the screw threads are cut into it. Threads not measured or modeled yet. Not used by the cut, the diameter above is
upper_body_cavity_inner_circle_diameter = 27.1;   // measured by hand, the round grinder part that protrudes from inside the cavity
upper_body_cavity_inner_circle_height = 4;       // measured by hand, how far it protrudes. ESTIMATE: drawn hanging down from the top of the cavity, position not confirmed
upper_body_cavity_inner_circle_hex_cutout_across_flats = 3.3;   // measured by hand (across assumed to be across flats), hex bolt cutout in the center of the inner circle
upper_body_cavity_inner_circle_hex_cutout_across_corners = upper_body_cavity_inner_circle_hex_cutout_across_flats / cos(30);   // 3.81, what cylinder($fn = 6) takes as its diameter
upper_body_cavity_inner_circle_hex_cutout_depth = 2;   // ESTIMATE: not measured yet
upper_body_metal_color = "#6e625e";         // brown-gray metal, from the photo
upper_body_grip_color = "#23282e";          // black grip band, from the photo
upper_body_bottom_z = lower_body_bottom_pad_height + lower_body_main_height;   // 58.0, derived: the upper body sits on the shoulder of the lower body (top of the main section)

upper_body_metal_top_z = upper_body_bottom_z + upper_body_total_height;   // derived: top of the metal body, the shaft stops here and does not stick out
upper_body_hex_shaft = 6.4;          // measured by hand (a 1/4" hex would be 6.35)
upper_body_hex_shaft_across_corners = upper_body_hex_shaft / cos(30);   // 7.51, what cylinder($fn = 6) takes as its diameter

// ---------- handle ----------
// socket, upper part: the upright cylinder the arm comes off, sits on top of the grinder rim, the visible part
handle_socket_upper_diameter = 15.9;         // measured by hand
handle_socket_upper_height = 10.1;           // measured by hand, the part visible outside the grinder
// socket, lower part: narrower cylinder on the same axis, goes down into the grinder through the lid hole, not visible
handle_socket_lower_diameter = 13.1;         // measured by hand
handle_socket_lower_height = 13.5;             // measured by hand, below the socket
handle_socket_lower_groove_width = 2;        // measured by hand
handle_socket_lower_groove_distance_below_upper = 3;       // measured by hand, from the bottom of the upper part of the socket down to the top of the groove
handle_socket_lower_groove_depth = 1;        // ESTIMATE: "closer to 1". The real groove is rounded (circular arc profile), modeled as an arc of that width and depth
handle_socket_lower_hex_pocket_wall_thickness = 3.3;   // measured by hand, wall on one hex face, from the flat out to the plain outer surface of the lower part (not the groove). Source of truth for the pocket size
handle_socket_lower_hex_pocket_across_flats = handle_socket_lower_diameter - 2 * handle_socket_lower_hex_pocket_wall_thickness;   // 6.5, derived, leaves 0.1 over the 6.4 shaft
handle_socket_lower_hex_pocket_across_corners = handle_socket_lower_hex_pocket_across_flats / cos(30);   // 7.51, derived, what cylinder($fn = 6) takes as its diameter
handle_socket_lower_hex_pocket_depth = handle_socket_lower_height + 0.5;   // hex pocket in the lower part of the socket, deep enough for the whole shaft
// arm, estimates
handle_rod_diameter = 5.9;               // measured by hand
handle_metal_end_to_end_length = 139.5;  // measured by hand, whole metal handle stood upright (no ball): far edge of the socket to far edge of the bent end rod
handle_arm_axis_to_axis_length = handle_metal_end_to_end_length - handle_socket_upper_diameter / 2 - handle_rod_diameter / 2;   // socket axis to bent end axis, 128.6
handle_bent_end_tip_to_arm_edge_length = 43.5;         // measured by hand, ball stub tip to the outer edge of the arm, parallel to the socket axis
wooden_ball_diameter = 40;                // measured, the wooden ball is a sphere with one flat
wooden_ball_height_across_flat = 38.8;    // measured by hand, from the flat side (where it sits on the rod) to the opposite side of the ball. Source of truth for the flat
wooden_ball_flat_depth = wooden_ball_diameter - wooden_ball_height_across_flat;   // 1.2, derived: how much is shaved off the sphere at the flat (you said about 1)
handle_stub_tip_diameter = 4.6;         // measured by hand, the round tip
handle_stub_total_length = 3.5;         // measured by hand (around), INCLUDES the neck: from the end of the rod to the top of the tip. Tip alone is 2.5 (measured), neck is 1
handle_stub_neck_length = 1;      // measured by hand, how wide the round groove is along the stub, between the end of the rod and the tip
handle_stub_neck_diameter = 3.5;  // ESTIMATE: diameter at the bottom of the round groove. You said 2.5 is too thin; 3.5 is my guess from the reference photo, not measured
handle_stub_tip_chamfer_length = 1.3;   // ESTIMATE (you said 1.3): how far along the stub the chamfer runs, measured along the stub axis
handle_stub_tip_chamfer_angle_from_axis = 30;   // ESTIMATE: angle of the chamfer surface from the stub axis, in degrees. 45 was too steep, so smaller = more gradual taper (0 = no chamfer, 90 = flat end face). Not measured
handle_stub_tip_chamfer_inset = handle_stub_tip_chamfer_length * tan(handle_stub_tip_chamfer_angle_from_axis);   // 0.75, derived: how much the radius shrinks across the chamfer
handle_stub_tip_fillet_radius = 0.4;   // ESTIMATE: radius of the rounded edges of the tip (no sharp corners), my guess, not measured
wooden_ball_hole_diameter = 6.1;          // measured by hand, plain round hole in the flat. NOTE: wider than the stub tip (4.6), so the stub does not fill it
wooden_ball_hole_depth = 20;            // ESTIMATE: "probably closer to 20", very deep, not measured

// handle heights, measured from the bottom of the upper part of the socket (z = 0)
handle_bent_end_rod_rise = handle_bent_end_tip_to_arm_edge_length - handle_stub_total_length - handle_rod_diameter / 2;   // arm axis to the end of the bent end rod, 37.05
handle_arm_center_height = handle_socket_upper_height / 2;                  // rod leaves the middle of the socket
handle_bent_end_rod_top_z = handle_arm_center_height + handle_bent_end_rod_rise;
handle_elbow_bend_radius = 5.5;        // ESTIMATE, guessed from reference_material/radius_bend_in_arm.HEIC (about +-1.5): bend radius of the rod where the arm turns up into the bent end, measured to the rod centre line
wooden_ball_center_z = handle_bent_end_rod_top_z + wooden_ball_diameter / 2 - wooden_ball_flat_depth;   // 60.9, derived: the flat rests on the end of the bent end, the sphere center is above the flat by radius minus flat depth

// ---------- exploded view ----------
explode_distance = 30;                 // spacing between neighbouring parts when exploded, set to 0 for assembled

// ---------- derived heights ----------
body_top_rim_z = upper_body_metal_top_z + lid_outer_ring_thickness;   // 175.6, derived: top of the metal plus the lid ring (body_total_height, measured 175.5, is no longer used for placement)

// removes the y > 0 half of whatever it wraps when grinder_view is assembled_cut_in_half. It sits INSIDE each color() so the cut face takes that part's color
module cut_half() {
    if (grinder_view == "assembled_cut_in_half") difference() {
        children();
        translate([-300, 0, -300]) cube([600, 300, 800]);
    }
    else children();
}

// lower metal body, unscrewed from the rest. z = 0 is the bottom of the pad (assumed, not confirmed).
// bottom pad, main section at lower_body_main_diameter, then the recessed tube on top
module lower_body() {
    metal_bottom_z = lower_body_bottom_pad_height;
    recess_bottom_z = metal_bottom_z + lower_body_main_height;
    cut_half() difference() {
        union() {
            color("dimgray") cylinder(d = lower_body_bottom_pad_diameter, h = lower_body_bottom_pad_height + 0.01);
            color("darkgray") translate([0, 0, metal_bottom_z]) cylinder(d = lower_body_main_diameter, h = lower_body_main_height);
            color("darkgray") translate([0, 0, recess_bottom_z - 0.01]) cylinder(d = lower_body_top_recess_diameter, h = lower_body_top_recess_height + 0.01);
        }
        // hollow: plain cylinder cut down from the top, lower_body_bore_depth deep (closed floor at the bottom)
        translate([0, 0, lower_body_total_height - lower_body_bore_depth]) cylinder(d = lower_body_bore_diameter, h = lower_body_bore_depth + 0.1);
    }
}

// top body: ONE piece. The lower section (51.9 wide) and the clicking adjuster section at the top (54.5 wide) are the same part.
// the lid recess is cut into the top (rough, plain cylinders for now)
module upper_body() {
    bottom_ring_top_z = upper_body_bottom_z + upper_body_gap_grip_band_to_bottom;
    grip_band_top_z = bottom_ring_top_z + upper_body_grip_band_height;
    adjuster_bottom_z = upper_body_bottom_z + upper_body_lower_height;
    adjuster_top_z = adjuster_bottom_z + upper_body_clicker_height;
    // bottom ring (metal), with the grounds cavity cut into the bottom (plain bore for now)
    color(upper_body_metal_color) cut_half() difference() {
        translate([0, 0, upper_body_bottom_z]) cylinder(d = upper_body_lower_diameter, h = upper_body_gap_grip_band_to_bottom + 0.01);
        translate([0, 0, upper_body_bottom_z - 0.1]) cylinder(d = upper_body_cavity_diameter, h = upper_body_cavity_depth + 0.1);
    }
    // inner circle inside the cavity, hangs down from the top of the cavity
    inner_circle_bottom_z = upper_body_bottom_z + upper_body_cavity_depth - upper_body_cavity_inner_circle_height;
    color(upper_body_metal_color) cut_half() difference() {
        translate([0, 0, inner_circle_bottom_z]) cylinder(d = upper_body_cavity_inner_circle_diameter, h = upper_body_cavity_inner_circle_height + 0.01);
        translate([0, 0, inner_circle_bottom_z - 0.1]) cylinder(d = upper_body_cavity_inner_circle_hex_cutout_across_corners, h = upper_body_cavity_inner_circle_hex_cutout_depth + 0.1, $fn = 6);
    }
    // grip band (black)
    color(upper_body_grip_color) cut_half() translate([0, 0, bottom_ring_top_z]) cylinder(d = upper_body_grip_band_diameter, h = upper_body_grip_band_height + 0.01);
    // index step under the clicking section (metal)
    color(upper_body_metal_color) cut_half() translate([0, 0, grip_band_top_z]) cylinder(d = upper_body_lower_diameter, h = upper_body_gap_clicker_to_grip_band + 0.01);
    // clicking section, with the lid recess (metal)
    color(upper_body_metal_color) cut_half() difference() {
        union() {
            translate([0, 0, adjuster_bottom_z]) cylinder(d1 = upper_body_clicker_diameter - upper_body_clicker_bottom_chamfer_diameter_reduction, d2 = upper_body_clicker_diameter, h = upper_body_clicker_bottom_chamfer_height);
            translate([0, 0, adjuster_bottom_z + upper_body_clicker_bottom_chamfer_height - 0.01]) cylinder(d = upper_body_clicker_diameter, h = upper_body_clicker_height - upper_body_clicker_bottom_chamfer_height + 0.01);
        }
        translate([0, 0, adjuster_top_z - upper_body_hopper_depth]) cylinder(d = upper_body_hopper_diameter, h = upper_body_hopper_depth + 0.1);
    }
}

// separate plastic cap on top of the grinder (the twisting part).
// one piece: the ring, a flat top plate across the whole top (flush with the rim, no recess) with the handle hole, and the skirt going down into the grinder.
// the gasket (O-ring) is its own module, lid_gasket(), so it is not part of the printed cap
// gasket: rubber ring around the skirt, centered vertically on the skirt
module lid_gasket() {
    skirt_bottom_z = body_top_rim_z - lid_outer_ring_thickness - lid_inner_ring_height;
    gasket_bottom_z = skirt_bottom_z + (lid_inner_ring_height - lid_gasket_height) / 2;
    // round O-ring: circular cross-section, diameter = lid_gasket_height, sunk lid_gasket_embed_depth into the inner ring
    gasket_center_radius = lid_inner_ring_diameter / 2 + lid_gasket_protrusion - lid_gasket_height / 2;
    color("#3a3a3a") cut_half() translate([0, 0, gasket_bottom_z + lid_gasket_height / 2]) rotate_extrude($fn = 96)
        translate([gasket_center_radius, 0]) circle(d = lid_gasket_height, $fn = 32);
}

module lid() {
    ring_bottom_z = body_top_rim_z - lid_outer_ring_thickness;
    skirt_bottom_z = ring_bottom_z - lid_inner_ring_height;
    color("lightsteelblue") cut_half() difference() {
        union() {
            translate([0, 0, ring_bottom_z]) cylinder(d = lid_outer_ring_diameter, h = lid_outer_ring_thickness);
            translate([0, 0, skirt_bottom_z]) cylinder(d = lid_inner_ring_diameter, h = body_top_rim_z - skirt_bottom_z);
        }
        // shallow step in the top face around the center cutout
        translate([0, 0, body_top_rim_z - lid_center_recess_depth]) cylinder(d = lid_center_cutout_diameter + 2 * lid_center_recess_width, h = lid_center_recess_depth + 0.1);
        // hole through the whole lid for the lower part of the handle socket
        translate([0, 0, skirt_bottom_z - 0.1]) cylinder(d = lid_center_cutout_diameter, h = body_top_rim_z - skirt_bottom_z + 0.2);
    }
}

module shaft() {
    color("silver") cut_half() translate([0, 0, upper_body_metal_top_z - upper_body_hopper_depth - 0.1])
        cylinder(d = upper_body_hex_shaft_across_corners, h = upper_body_hopper_depth + 0.1, $fn = 6);
}

// half cross section (x >= 0) of the whole stub, z = 0 is the end of the rod. It runs down to z = -1 (hidden inside the rod) so nothing shows a gap.
// shape: straight band, chamfer on the end, convex corners rounded with a fillet (done on the full width mirrored shape so the rounding never touches the axis),
// then a round (circular arc) groove for the neck cut into the band, neck_length wide and down to neck_diameter
module stub_profile(tip_diameter, total_length, neck_length, neck_diameter, chamfer_length, chamfer_inset, fillet_radius) {
    tip_radius = tip_diameter / 2;
    straight_top_z = total_length - chamfer_length;
    groove_depth = tip_radius - neck_diameter / 2;
    groove_arc_radius = (pow(neck_length / 2, 2) + pow(groove_depth, 2)) / (2 * groove_depth);
    groove_arc_center_x = neck_diameter / 2 + groove_arc_radius;
    difference() {
        intersection() {
            offset(r = fillet_radius) offset(delta = -fillet_radius) polygon([
                [-tip_radius, -1], [tip_radius, -1], [tip_radius, straight_top_z],
                [tip_radius - chamfer_inset, total_length], [-(tip_radius - chamfer_inset), total_length], [-tip_radius, straight_top_z]
            ]);
            translate([0, -2]) square([tip_diameter, total_length + 4]);
        }
        translate([groove_arc_center_x, neck_length / 2]) circle(r = groove_arc_radius, $fn = 48);
    }
}

// stub on the end of the bent end rod: round groove (the neck), then a tip with a chamfered end and filleted edges. z = 0 is the end of the rod.
module handle_stub() {
    rotate_extrude() stub_profile(handle_stub_tip_diameter, handle_stub_total_length, handle_stub_neck_length, handle_stub_neck_diameter,
        handle_stub_tip_chamfer_length, handle_stub_tip_chamfer_inset, handle_stub_tip_fillet_radius);
}

// rod of the handle in three pieces: straight arm, rounded elbow bend, straight bent end. origin = bottom of the socket.
// extensions lengthen the free ends (used by cutouts that need clearance past the ends)
module handle_arm_straight(rod_diameter, arm_start_extension = 0) {
    translate([-arm_start_extension, 0, handle_arm_center_height]) rotate([0, 90, 0])
        cylinder(d = rod_diameter, h = arm_start_extension + handle_arm_axis_to_axis_length - handle_elbow_bend_radius + 0.01);
}

// quarter turn from the arm (+X) up into the bent end (+Z). sweep_start_deg / sweep_angle_deg pick a slice of it (0 = arm side, 90 = bent end side)
module handle_elbow_bend(rod_diameter, sweep_start_deg = 0, sweep_angle_deg = 90) {
    translate([handle_arm_axis_to_axis_length - handle_elbow_bend_radius, 0, handle_arm_center_height + handle_elbow_bend_radius])
        rotate([90, 0, 0]) rotate([0, 0, -90 + sweep_start_deg])
            rotate_extrude(angle = sweep_angle_deg) translate([handle_elbow_bend_radius, 0]) circle(d = rod_diameter);
}

module handle_bent_end_straight(rod_diameter, bent_end_extension = 0) {
    translate([handle_arm_axis_to_axis_length, 0, handle_arm_center_height + handle_elbow_bend_radius - 0.01])
        cylinder(d = rod_diameter, h = handle_bent_end_rod_rise - handle_elbow_bend_radius + bent_end_extension + 0.01);
}

// metal handle. origin = bottom of the upper part of the socket, the lower part hangs below it (-z), bent end rises (+z)
module handle_metal() {
    color("silver") cut_half() difference() {
        union() {
            cylinder(d = handle_socket_upper_diameter, h = handle_socket_upper_height);
            translate([0, 0, -handle_socket_lower_height]) cylinder(d = handle_socket_lower_diameter, h = handle_socket_lower_height);
            handle_arm_straight(handle_rod_diameter);
            handle_elbow_bend(handle_rod_diameter);
            handle_bent_end_straight(handle_rod_diameter);
            translate([handle_arm_axis_to_axis_length, 0, handle_bent_end_rod_top_z]) handle_stub();
        }
        // rounded groove ring on the lower part of the socket: a circular arc that is handle_socket_lower_groove_width wide at the surface and handle_socket_lower_groove_depth deep
        groove_arc_radius = (pow(handle_socket_lower_groove_width / 2, 2) + pow(handle_socket_lower_groove_depth, 2)) / (2 * handle_socket_lower_groove_depth);
        groove_arc_center_radius = handle_socket_lower_diameter / 2 - handle_socket_lower_groove_depth + groove_arc_radius;
        translate([0, 0, -handle_socket_lower_groove_distance_below_upper - handle_socket_lower_groove_width / 2])
            rotate_extrude() translate([groove_arc_center_radius, 0]) circle(r = groove_arc_radius, $fn = 48);
        // hex pocket that fits over the shaft
        translate([0, 0, -handle_socket_lower_height - 0.1]) cylinder(d = handle_socket_lower_hex_pocket_across_corners, h = handle_socket_lower_hex_pocket_depth + 0.1, $fn = 6);
    }
}

// wooden ball: a sphere with one flat (where it sits on the end of the bent end rod) and a plain round blind hole in the flat
module wooden_ball() {
    color("burlywood") cut_half() translate([handle_arm_axis_to_axis_length, 0, handle_bent_end_rod_top_z]) difference() {
        intersection() {
            translate([0, 0, wooden_ball_diameter / 2 - wooden_ball_flat_depth]) sphere(d = wooden_ball_diameter);
            translate([-wooden_ball_diameter / 2, -wooden_ball_diameter / 2, 0]) cube(wooden_ball_diameter);
        }
        translate([0, 0, -0.1]) cylinder(d = wooden_ball_hole_diameter, h = wooden_ball_hole_depth + 0.1);
    }
}

module handle() {
    handle_metal();
    wooden_ball();
}

// pieces along the grinder axis, each moved up by its slot number times explode_distance:
// lower body and top body (with the shaft) stay together, then lid with its cap, handle, wooden ball
module grinder_body() {
    lower_body();
    upper_body();
    shaft();
}

module grinder_lid_with_cap() {
    lid();
    lid_gasket();
}

// the upper metal body (top body plus the shaft), without the lower metal body
module grinder_upper_body() {
    upper_body();
    shaft();
}

// exploded view: lid with cap, handle and ball go up (the lower metal body drops down below the upper body)
// grinder_view picks exploded, assembled, or assembled and cut in half down the middle (see cut_half(), it removes the y > 0 half, look from the front)
module grinder() {
    spread = grinder_view == "exploded" ? explode_distance : 0;
    translate([0, 0, -1 * spread]) lower_body();
    grinder_upper_body();
    translate([0, 0, 1 * spread]) grinder_lid_with_cap();
    if (show_handle) translate([0, 0, body_top_rim_z + 2 * spread]) {
        handle_metal();
        translate([0, 0, spread]) wooden_ball();   // slides off the stub
    }
}

if (show_grinder_preview) grinder();
