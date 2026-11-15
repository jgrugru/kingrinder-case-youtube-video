// KINGrinder K6 travel case: clamshell, grinder on the split plane, handle and ball in a layer underneath.
//
// The cavity is a cutout of the real grinder replica (kingrinder_k6.scad): the stepped body profile and the
// handle parts, each grown by cutout_clearance_mm on every side for wiggle room.
//
// Split at the grinder axis (z=0). Each half prints with its outer face on the bed and the cavity facing up,
// so no supports. Halves are joined by a tongue (lower half) that fits a groove (upper half). The tongue carries a snap bead and the groove a detent recess; the seam and the pull grip ridges on the two long side walls come from seam test pair E (see seam_test_log.md).
// The handle (no ball) lies flat in a layer below the grinder, the ball has its own round pocket next to it.
// Pockets are open upward, so no supports.
//
// Pick the view with the "part" dropdown in the Customizer.
include <../kingrinder_k6/kingrinder_k6.scad>
show_grinder_preview = false;      // use the replica's variables and modules only, do not draw it here

// ---------- view selection ----------
part = "open_fit_no_grinder";   // [exploded:Exploded, open_fit:Seated no top half, open_fit_no_grinder:Handle and ball only, lower_half_cut_through_ball:Lower half cut through ball, lower_half_cut_through_handle_scoop:Lower half cut through handle scoop, both_halves_cut_through_ball:Both halves cut through ball, both_halves_cut_through_handle_scoop:Both halves cut through handle scoop, print_lower:Print lower half, print_upper:Print upper half, print_test_section_cup_end_lower:Print test section cup end lower half, print_test_section_cup_end_upper:Print test section cup end upper half, print_test_sections_plate:Print both test sections on one plate]
test_section_length_mm = 40;       // quick fit test: only the cup end of the lower half (end wall, handle socket pocket, corners, tongue), measured from the cup end
test_sections_plate_gap_mm = 10;   // gap between the lower and upper test sections on the shared print plate
explode_gap_mm = 90;              // vertical distance of the upper half above the lower half in the exploded view (grinder, handle and ball sit halfway)

// ---------- case settings ----------
wall_thickness_mm = 3.6;           // side walls, floor and top
end_wall_thickness_mm = 5.5;       // the two end walls (cup end and collar end); thicker so the groove and the rounded corners keep real wall next to the cavity
cutout_clearance_mm = 1.5;         // wiggle room added around the grinder body and the handle, per side
bed_chamfer_mm = 3;                // 45 degree chamfer on the outer top and bottom edges (the bottom one touches the build plate, so no supports)
corner_radius_mm = 9;              // vertical corner rounding, keep larger than bed_chamfer_mm
tongue_height_mm = 5;
tongue_half_thickness_mm = 0.6;
groove_half_width_mm = 0.80;       // 0.20 mm clearance per side around the tongue (seam test pair E)
// snap bead, values from seam test pair E (best click and still pulls apart): bead on the tongue's outer face, detent recess in the groove's outer wall
seam_center_from_outside_mm = 1.95;  // seam centre line, measured in from the outer surface
bead_height_mm = 0.25;               // bead height on the tongue
bead_half_height_mm = 0.5;           // bead half height along the tongue
bead_center_height_mm = 3.8;         // bead centre, measured up from the seam plane
recess_depth_mm = 0.2;               // detent recess depth in the groove wall
recess_half_height_mm = 0.6;
bead_slice_height_mm = 0.1;          // slice height used to build the bead profile

// pull grip ridges (from seam test pair E, patch length scaled up): saw-tooth ridges on the middle of the two long side walls, no supports needed
grip_ridge_count = 3;              // ridges per patch
grip_ridge_protrusion_mm = 1.2;    // how far each ridge sticks out from the wall
grip_ridge_pitch_mm = 2.2;         // distance between ridges, measured along the pull direction
grip_ridge_length_mm = 30;         // length of each patch along the end wall, centred on the wall
grip_ridge_gap_from_seam_mm = 2;   // seam to the first (finger) face of the ridges
grip_ridge_wall_embed_mm = 1;      // how far each ridge is buried inside the wall

ball_pocket_extra_clearance_mm = 0.5;   // extra wiggle room for the ball pocket only, on top of cutout_clearance_mm
ball_to_grinder_gap_mm = 1.0;           // air between the wooden ball and the real grinder body (the pocket adds its own clearance on top)
pocket_lift_height_mm = 80;             // handle and ball pockets are stretched upward by this much so they open into the grinder cavity

// finger scoops: dips next to the ball and next to the handle arm so a fingertip can get under each.
// each is a flattened, stretched ellipsoid so its floor rises gently instead of dropping steeply into the crevice
ball_scoop_radius_mm = 11;
ball_scoop_stretch = [1.7, 1.1, 1];                  // longer along the case, gentle slope into the ball pocket
handle_scoop_radius_mm = 13;
handle_scoop_stretch = [1.3, 1.4, 0.55];             // flattened: shallow, wide slope into the arm slot
handle_scoop_distance_from_socket_mm = 22;           // along the arm
handle_scoop_offset_from_arm_mm = 8;                 // beside the arm, on the ball side
handle_scoop_floor_below_arm_mm = 5;                 // scoop floor below the underside of the arm slot
ball_scoop_gap_to_ball_pocket_mm = 3;                // scoop center sits this far beyond the pocket edge, toward the cup end

// ---------- sizes taken from the replica ----------
cavity_radius_mm = collar_diameter_mm / 2 + cutout_clearance_mm;      // widest part of the grinder plus wiggle room
cavity_length_mm = total_height_mm + 2 * cutout_clearance_mm;

// handle extents along its own socket axis, measured from the bottom of the socket (insert side is negative)
handle_extent_insert_side_mm = handle_insert_length_mm + cutout_clearance_mm;
handle_extent_bent_end_side_mm = handle_arm_height_mm + handle_rise_mm + handle_ball_stub_length_mm + cutout_clearance_mm;
handle_total_extent_mm = handle_extent_insert_side_mm + handle_extent_bent_end_side_mm;

// ---------- placement ----------
// handle: socket axis along Y (insert toward +Y), arm along +X, centered on the grinder axis in Y
handle_socket_x_mm = end_wall_thickness_mm + handle_socket_diameter_mm / 2 + cutout_clearance_mm;
handle_origin_y_mm = (handle_extent_bent_end_side_mm - handle_extent_insert_side_mm) / 2;

// ball: in the free area between the arm and the far edge of the bent end, halfway along the arm
ball_free_start_local_z_mm = handle_arm_height_mm + handle_rod_diameter_mm / 2 + cutout_clearance_mm;
ball_center_x_mm = handle_socket_x_mm + handle_arm_length_mm / 2;
ball_center_y_mm = handle_origin_y_mm - (ball_free_start_local_z_mm + handle_extent_bent_end_side_mm) / 2;
ball_pocket_radius_mm = handle_ball_diameter_mm / 2 + cutout_clearance_mm + ball_pocket_extra_clearance_mm;

// the ball sits off to the side of the grinder axis, so it can tuck up closer than straight below:
// keep its center a fixed distance from the axis. The handle shares this height.
layer_center_z_mm = -sqrt(pow(collar_diameter_mm / 2 + ball_to_grinder_gap_mm + handle_ball_diameter_mm / 2, 2) - pow(ball_center_y_mm, 2));

// scoops
handle_scoop_x_mm = handle_socket_x_mm + handle_scoop_distance_from_socket_mm;
handle_scoop_y_mm = handle_origin_y_mm - handle_arm_height_mm - handle_scoop_offset_from_arm_mm;
handle_scoop_center_z_mm = layer_center_z_mm - handle_rod_diameter_mm / 2 - cutout_clearance_mm - handle_scoop_floor_below_arm_mm + handle_scoop_radius_mm * handle_scoop_stretch[2];
handle_scoop_center = [handle_scoop_x_mm, handle_scoop_y_mm, handle_scoop_center_z_mm];
ball_scoop_center = [ball_center_x_mm - ball_pocket_radius_mm - ball_scoop_gap_to_ball_pocket_mm, ball_center_y_mm, layer_center_z_mm - ball_pocket_radius_mm + ball_scoop_radius_mm];

// case extents: X = length, Y = width, Z = height (split plane at z=0). e = [x0, x1, y0, y1, z0, z1]
case_length_mm = cavity_length_mm + 2 * end_wall_thickness_mm;
case_half_width_mm = max(cavity_radius_mm, handle_total_extent_mm / 2) + wall_thickness_mm;
case_z_min_mm = layer_center_z_mm - ball_pocket_radius_mm - wall_thickness_mm;
case_z_max_mm = cavity_radius_mm + wall_thickness_mm;
case_extents = [0, case_length_mm, -case_half_width_mm, case_half_width_mm, case_z_min_mm, case_z_max_mm];

// ---------- placement modules ----------
// grinder lies along X, cup end at low X
module place_grinder() {
    translate([end_wall_thickness_mm + cutout_clearance_mm, 0, 0]) rotate([0, 90, 0]) children();
}

// handle lies flat under the grinder, socket insert pointing +Y, arm along +X. origin = socket bottom
module place_handle() {
    translate([handle_socket_x_mm, handle_origin_y_mm, layer_center_z_mm]) rotate([90, 0, 0]) children();
}

// origin = ball center
module place_ball() {
    translate([ball_center_x_mm, ball_center_y_mm, layer_center_z_mm]) children();
}

// ---------- cutouts ----------
// side profile of the grinder body (radius vs height, bottom of the cup at z=0), grown by the clearance and spun around the axis
module grinder_body_cutout() {
    chamfer_bottom_z = collar_bottom_z_mm + collar_lower_height_mm;
    full_diameter_bottom_z = chamfer_bottom_z + collar_chamfer_height_mm;
    rotate_extrude() intersection() {
        offset(delta = cutout_clearance_mm) polygon([
            [0, 0],
            [body_diameter_mm / 2, 0],
            [body_diameter_mm / 2, chamfer_bottom_z],
            [collar_diameter_mm / 2, full_diameter_bottom_z],
            [collar_diameter_mm / 2, top_rim_z_mm],
            [0, top_rim_z_mm]
        ]);
        translate([0, -cutout_clearance_mm]) square([cavity_radius_mm, top_rim_z_mm + 2 * cutout_clearance_mm]);
    }
}

// stretches one primitive upward (case +Z = handle-local +Y) so its pocket has no roof
module lifted_in_handle_frame() {
    hull() {
        children();
        translate([0, pocket_lift_height_mm, 0]) children();
    }
}

// the handle's parts (no ball), each grown by the clearance. origin = socket bottom, same as handle_metal() in the replica
module handle_cutout() {
    c = cutout_clearance_mm;
    lifted_in_handle_frame() translate([0, 0, -c]) cylinder(d = handle_socket_diameter_mm + 2 * c, h = handle_socket_height_mm + 2 * c);
    // insert pocket is stretched along X on both sides to the socket pocket's width, so both its X faces are flush with the socket pocket (no thin ledges)
    insert_to_socket_radius_difference_mm = (handle_socket_diameter_mm - handle_insert_diameter_mm) / 2;
    lifted_in_handle_frame() hull() for (shift_x = [-insert_to_socket_radius_difference_mm, insert_to_socket_radius_difference_mm])
        translate([shift_x, 0, -handle_insert_length_mm - c]) cylinder(d = handle_insert_diameter_mm + 2 * c, h = handle_insert_length_mm + c);
    lifted_in_handle_frame() translate([-c, 0, handle_arm_height_mm]) rotate([0, 90, 0]) cylinder(d = handle_rod_diameter_mm + 2 * c, h = handle_arm_length_mm + 2 * c);
    lifted_in_handle_frame() translate([handle_arm_length_mm, 0, handle_arm_height_mm]) sphere(d = handle_rod_diameter_mm + 2 * c);   // rounded elbow
    lifted_in_handle_frame() translate([handle_arm_length_mm, 0, handle_arm_height_mm - c]) cylinder(d = handle_rod_diameter_mm + 2 * c, h = handle_rise_mm + handle_ball_stub_length_mm + 2 * c);
}

// round pocket for the wooden ball, origin = ball center
module ball_cutout() {
    hull() {
        sphere(r = ball_pocket_radius_mm);
        translate([0, 0, pocket_lift_height_mm]) sphere(r = ball_pocket_radius_mm);
    }
}

module finger_scoop(center, radius, stretch) {
    translate(center) hull() {
        scale(stretch) sphere(r = radius);
        translate([0, 0, pocket_lift_height_mm]) scale(stretch) sphere(r = radius);
    }
}

// handle and ball pockets (and scoops) only exist in the lower half (z <= 0)
module case_voids() {
    place_grinder() grinder_body_cutout();
    intersection() {
        union() {
            place_handle() handle_cutout();
            place_ball() ball_cutout();
            finger_scoop(ball_scoop_center, ball_scoop_radius_mm, ball_scoop_stretch);
            finger_scoop(handle_scoop_center, handle_scoop_radius_mm, handle_scoop_stretch);
        }
        translate([-1, -300, -300]) cube([400, 600, 300.01]);
    }
}

// ---------- case body ----------
module outline2d(e) {
    translate([e[0], e[2]]) offset(r = corner_radius_mm) offset(delta = -corner_radius_mm) square([e[1] - e[0], e[3] - e[2]]);
}

// rounded box with a chamfer on the top and bottom faces
module shell(e) {
    hull() {
        translate([0, 0, e[4]]) linear_extrude(0.01) offset(r = -bed_chamfer_mm) outline2d(e);
        translate([0, 0, e[4] + bed_chamfer_mm]) linear_extrude(e[5] - e[4] - 2 * bed_chamfer_mm) outline2d(e);
        translate([0, 0, e[5] - 0.01]) linear_extrude(0.01) offset(r = -bed_chamfer_mm) outline2d(e);
    }
}

// ring between two insets measured in from the outer outline
module seam_ring2d(e, inset_out, inset_in) {
    difference() {
        offset(r = -inset_out) outline2d(e);
        offset(r = -inset_in) outline2d(e);
    }
}

function triangle_profile(h, centre, half_width, peak) = max(0, peak * (1 - abs(h - centre) / half_width));

// tongue on the lower half, z up from the seam plane, with a triangular bead on its outer face
module tongue(e) {
    linear_extrude(tongue_height_mm) seam_ring2d(e, seam_center_from_outside_mm - tongue_half_thickness_mm, seam_center_from_outside_mm + tongue_half_thickness_mm);
    for (h = [bead_center_height_mm - bead_half_height_mm : bead_slice_height_mm : bead_center_height_mm + bead_half_height_mm - bead_slice_height_mm / 2])
        translate([0, 0, h]) linear_extrude(bead_slice_height_mm)
            seam_ring2d(e, seam_center_from_outside_mm - tongue_half_thickness_mm - triangle_profile(h + bead_slice_height_mm / 2, bead_center_height_mm, bead_half_height_mm, bead_height_mm), seam_center_from_outside_mm + tongue_half_thickness_mm);
}

// groove in the upper half, z up from the seam plane, with a detent recess in its outer wall
module groove(e) {
    translate([0, 0, -0.01]) linear_extrude(tongue_height_mm + 0.41) seam_ring2d(e, seam_center_from_outside_mm - groove_half_width_mm, seam_center_from_outside_mm + groove_half_width_mm);
    for (h = [bead_center_height_mm - recess_half_height_mm : bead_slice_height_mm : bead_center_height_mm + recess_half_height_mm - bead_slice_height_mm / 2])
        translate([0, 0, h]) linear_extrude(bead_slice_height_mm)
            seam_ring2d(e, seam_center_from_outside_mm - groove_half_width_mm - triangle_profile(h + bead_slice_height_mm / 2, bead_center_height_mm, recess_half_height_mm, recess_depth_mm), seam_center_from_outside_mm + groove_half_width_mm);
}

// grip ridges on both long side walls (y = low and y = high), centred along the case length, so one thumb and one finger can pinch across the case width
// z_direction = -1 for the lower half, +1 for the upper half
// flat finger face toward the seam, 45 degree underside away from it, so each half prints without supports
module grip_ridges(e, z_direction) {
    for (wall_y = [e[2], e[3]])
        translate([(e[0] + e[1]) / 2, wall_y, 0]) mirror([0, wall_y == e[2] ? 0 : 1, 0])
            for (i = [0 : grip_ridge_count - 1]) {
                top_z = z_direction * (grip_ridge_gap_from_seam_mm + i * grip_ridge_pitch_mm);
                bottom_z = top_z + z_direction * grip_ridge_protrusion_mm;
                rotate([90, 0, 90]) linear_extrude(grip_ridge_length_mm, center = true)
                    polygon([[grip_ridge_wall_embed_mm, top_z], [-grip_ridge_protrusion_mm, top_z], [0, bottom_z], [grip_ridge_wall_embed_mm, bottom_z]]);
            }
}

module case_solid(e) {
    difference() {
        shell(e);
        case_voids();
    }
}

module lower_half(e) {
    intersection() {
        case_solid(e);
        translate([-1, -300, -200]) cube([400, 600, 200]);
    }
    tongue(e);
    grip_ridges(e, -1);
}

module upper_half(e) {
    difference() {
        intersection() {
            case_solid(e);
            translate([-1, -300, 0]) cube([400, 600, 200]);
        }
        groove(e);
    }
    grip_ridges(e, 1);
}

// everything with the half planes cut off at x = cut_x (view from the +X side to look into the cut)
module cut_off_beyond_x(cut_x) {
    intersection() {
        children();
        translate([-1, -300, -300]) cube([cut_x + 1, 600, 600]);
    }
}

// ---------- things that live in the case ----------
module ghost_grinder() {
    cup(); ring(); grip(); collar(); cap(); lid(); shaft();
}

module seated_grinder() {
    place_grinder() ghost_grinder();
}

module seated_handle_and_ball() {
    place_handle() handle_metal();
    place_ball() color("burlywood") sphere(d = handle_ball_diameter_mm);
}

// ---------- views ----------
module print_lower(e) { translate([0, 0, -e[4]]) lower_half(e); }
module print_upper(e) { translate([0, 0, e[5]]) rotate([180, 0, 0]) upper_half(e); }

// keeps x <= test_section_length_mm, with a 45 degree bed chamfer on the bed edge of the cut end.
// bed_face_at_top = false: lower half (bed face at z = e[4]); true: upper half (printed upside down, bed face at z = e[5])
module test_section_keep_region(e, bed_face_at_top = false) {
    mirror([0, 0, bed_face_at_top ? 1 : 0]) rotate([90, 0, 0]) linear_extrude(600, center = true) polygon([
        [-1, (bed_face_at_top ? -e[5] : e[4]) - 1],
        [test_section_length_mm - bed_chamfer_mm - 1, (bed_face_at_top ? -e[5] : e[4]) - 1],
        [test_section_length_mm, (bed_face_at_top ? -e[5] : e[4]) + bed_chamfer_mm],
        [test_section_length_mm, (bed_face_at_top ? -e[4] : e[5]) + 1],
        [-1, (bed_face_at_top ? -e[4] : e[5]) + 1]
    ]);
}

module print_test_section_cup_end_lower(e) {
    translate([0, 0, -e[4]]) intersection() {
        lower_half(e);
        test_section_keep_region(e);
    }
}

module print_test_section_cup_end_upper(e) {
    translate([0, 0, e[5]]) rotate([180, 0, 0]) intersection() {
        upper_half(e);
        test_section_keep_region(e, bed_face_at_top = true);
    }
}

// both test sections on one plate, side by side along X
module print_test_sections_plate(e) {
    print_test_section_cup_end_lower(e);
    translate([test_section_length_mm + test_sections_plate_gap_mm, 0, 0]) print_test_section_cup_end_upper(e);
}

// lower half stays, grinder, handle and ball float at half the gap, upper half at the full gap
module exploded(e) {
    color("tan") lower_half(e);
    translate([0, 0, explode_gap_mm / 2]) {
        seated_grinder();
        seated_handle_and_ball();
    }
    color("peru") translate([0, 0, explode_gap_mm]) upper_half(e);
}

// everything seated in the lower half, upper half left off
module open_fit(e) {
    color("tan") lower_half(e);
    seated_grinder();
    seated_handle_and_ball();
}

// same as the open fit, grinder left out so the handle and ball pockets are visible
module open_fit_no_grinder(e) {
    color("tan") lower_half(e);
    seated_handle_and_ball();
}

// lower half sliced open at cut_x, grinder, handle and ball stay whole
module lower_half_cut(e, cut_x) {
    color("tan") cut_off_beyond_x(cut_x) lower_half(e);
    seated_grinder();
    seated_handle_and_ball();
}

// both halves on and sliced open at cut_x, grinder, handle and ball stay whole
module both_halves_cut(e, cut_x) {
    cut_off_beyond_x(cut_x) {
        color("tan") lower_half(e);
        color("peru") upper_half(e);
    }
    seated_grinder();
    seated_handle_and_ball();
}

// ---------- dispatch ----------
if (part == "print_lower") print_lower(case_extents);
else if (part == "print_upper") print_upper(case_extents);
else if (part == "print_test_section_cup_end_lower") print_test_section_cup_end_lower(case_extents);
else if (part == "print_test_section_cup_end_upper") print_test_section_cup_end_upper(case_extents);
else if (part == "print_test_sections_plate") print_test_sections_plate(case_extents);
else if (part == "exploded") exploded(case_extents);
else if (part == "open_fit") open_fit(case_extents);
else if (part == "open_fit_no_grinder") open_fit_no_grinder(case_extents);
else if (part == "lower_half_cut_through_ball") lower_half_cut(case_extents, ball_center_x_mm);
else if (part == "lower_half_cut_through_handle_scoop") lower_half_cut(case_extents, handle_scoop_x_mm);
else if (part == "both_halves_cut_through_ball") both_halves_cut(case_extents, ball_center_x_mm);
else if (part == "both_halves_cut_through_handle_scoop") both_halves_cut(case_extents, handle_scoop_x_mm);
