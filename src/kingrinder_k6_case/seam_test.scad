// Snap-bead seam test box. Same wall thickness and corner radius as the case, just small.
// Two halves: half A carries a tongue with a bead on its outer face, half B has a groove with a detent recess.
// Each half prints on its outer face, seam facing up, no supports.
// Render with -D bead_height_mm=0.30 / 0.35 / 0.40 and -D part="seam_a" / "seam_b" / "seam_plate" (see seam_test_build.py).
// Self-contained on purpose: this file does NOT include kingrinder_k6_case.scad, so edits to the case cannot change this test.
// Round 3 pair E uses the same bead and clearance as round 2 pair D; only the pull grips changed (ridges on the two ends of the longest side). E was the best print and its settings are now in kingrinder_k6_case.scad.

part = "seam_exploded"; // [seam_exploded:Exploded, seam_closed:Closed, seam_assembly:Print layout one pair, seam_plate:Print plate for STL export, seam_a:Half A only, seam_b:Half B only]
explode_distance_mm = 0;           // [0:1:60] total gap between the halves; applies to Closed and Exploded views (Exploded never goes below exploded_minimum_gap_mm)
exploded_minimum_gap_mm = 20;      // smallest gap the Exploded view uses
bead_height_mm = 0.25;             // bead height, same as round 2 pair D, kept for round 3 pair E

seam_wall_thickness_mm = 3.6;      // case wall thickness used for the tested pairs
seam_corner_radius_mm = 6;         // vertical corner rounding of the test box
seam_bed_chamfer_mm = 0.8;         // chamfer on the face that touches the bed

// test box: 24 (X) x 16 (Z) x 16 (Y, two halves of 8)
box_length_mm = 24;
box_height_mm = 16;
half_thickness_mm = 8;
plate_spacing_mm = 44;
// round 2: A was the best click but too tight to pull apart, so go a little looser (smaller bead, more clearance)
plate_bead_heights_mm = [0.25];
plate_groove_half_widths_mm = [0.80];   // tongue half thickness is 0.6, so clearance per side = 0.20
plate_labels = ["E"];   // same letter on both halves of a pair

// pull-apart grip ridges: small 45 degree saw-tooth ridges on the two end walls of the longest side, printable without supports
grip_ridge_count = 3;              // ridges per wall
grip_ridge_protrusion_mm = 1.2;    // how far each ridge sticks out from the wall
grip_ridge_pitch_mm = 2.2;         // distance between ridges, measured along the pull direction
grip_ridge_length_mm = 7;          // length of each ridge along the wall, centred on the wall's flat part
grip_ridge_gap_from_seam_mm = 2;   // seam to the first (finger) face of the ridges
grip_ridge_wall_embed_mm = 1;      // how far each ridge is buried inside the wall

// snap-bead seam
seam_center_from_outside_mm = 1.95;  // seam centre line, measured in from the outer surface
seam_tongue_half_thickness_mm = 0.6;
seam_groove_half_width_mm = 0.80;    // 0.20 clearance per side, round 2 pair D, kept for round 3 pair E
seam_tongue_height_mm = 5;
bead_half_height_mm = 0.5;           // bead half height along the tongue
bead_center_height_mm = 3.8;         // bead centre, measured up from the seam plane
recess_depth_mm = 0.2;               // detent recess depth in the groove wall
recess_half_height_mm = 0.6;
bead_slice_height_mm = 0.1;          // slice height used to build the bead profile

module seam_outline2d() {
    offset(r = seam_corner_radius_mm) offset(delta = -seam_corner_radius_mm) square([box_length_mm, box_height_mm]);
}

// rounded box with a bed chamfer on both thickness faces (extents: z from -half_thickness_mm to +half_thickness_mm)
module seam_shell() {
    hull() {
        translate([0, 0, -half_thickness_mm]) linear_extrude(0.01) offset(delta = -seam_bed_chamfer_mm) seam_outline2d();
        translate([0, 0, -half_thickness_mm + seam_bed_chamfer_mm]) linear_extrude(2 * half_thickness_mm - 2 * seam_bed_chamfer_mm) seam_outline2d();
        translate([0, 0, half_thickness_mm - 0.01]) linear_extrude(0.01) offset(delta = -seam_bed_chamfer_mm) seam_outline2d();
    }
}

module seam2d(inset_out, inset_in) {
    difference() {
        offset(r = -inset_out) seam_outline2d();
        offset(r = -inset_in) seam_outline2d();
    }
}

function triangle_profile(h, centre, half_width, peak) = max(0, peak * (1 - abs(h - centre) / half_width));

// tongue in local coords: z = height above the seam plane
module tongue_local(bead_h) {
    linear_extrude(seam_tongue_height_mm) seam2d(seam_center_from_outside_mm - seam_tongue_half_thickness_mm, seam_center_from_outside_mm + seam_tongue_half_thickness_mm);
    for (h = [bead_center_height_mm - bead_half_height_mm : bead_slice_height_mm : bead_center_height_mm + bead_half_height_mm - bead_slice_height_mm / 2])
        translate([0, 0, h]) linear_extrude(bead_slice_height_mm)
            seam2d(seam_center_from_outside_mm - seam_tongue_half_thickness_mm - triangle_profile(h + bead_slice_height_mm / 2, bead_center_height_mm, bead_half_height_mm, bead_h), seam_center_from_outside_mm + seam_tongue_half_thickness_mm);
}

// groove in local coords: z = depth below the seam plane (0 at the plane, growing into half B)
module groove_local(groove_half_width_mm = seam_groove_half_width_mm) {
    translate([0, 0, -0.01]) linear_extrude(seam_tongue_height_mm + 0.41) seam2d(seam_center_from_outside_mm - groove_half_width_mm, seam_center_from_outside_mm + groove_half_width_mm);
    for (h = [bead_center_height_mm - recess_half_height_mm : bead_slice_height_mm : bead_center_height_mm + recess_half_height_mm - bead_slice_height_mm / 2])
        translate([0, 0, h]) linear_extrude(bead_slice_height_mm)
            seam2d(seam_center_from_outside_mm - groove_half_width_mm - triangle_profile(h + bead_slice_height_mm / 2, bead_center_height_mm, recess_half_height_mm, recess_depth_mm), seam_center_from_outside_mm + groove_half_width_mm);
}

module seam_solid() {
    difference() {
        rotate([90, 0, 0]) seam_shell();
        rotate([90, 0, 0]) translate([0, 0, -(half_thickness_mm - seam_wall_thickness_mm)])
            linear_extrude(2 * (half_thickness_mm - seam_wall_thickness_mm)) offset(r = -seam_wall_thickness_mm) seam_outline2d();
    }
}

// Grip ridges. Half-local coords: seam at y = 0, half extends to y = -half_thickness_mm (the bed face). x negative = away from the wall.
// Each ridge has a flat finger face toward the seam and a 45 degree underside toward the bed, so no supports.
function grip_ridge_profile_points(ridge_index) = let(
    top_y = -grip_ridge_gap_from_seam_mm - ridge_index * grip_ridge_pitch_mm,
    p = grip_ridge_protrusion_mm
) [[grip_ridge_wall_embed_mm, top_y], [-p, top_y], [0, top_y - p], [grip_ridge_wall_embed_mm, top_y - p]];

// all ridges of one wall, extruded along local z from 0 to grip_ridge_length_mm
module grip_ridges_wall_body() {
    for (i = [0 : grip_ridge_count - 1]) linear_extrude(grip_ridge_length_mm) polygon(grip_ridge_profile_points(i));
}

// ridges on one X wall (side 0 = -X wall, side 1 = +X wall)
module grip_ridges_x_wall_local(side) {
    translate([side == 0 ? 0 : box_length_mm, 0, (box_height_mm - grip_ridge_length_mm) / 2]) mirror([side, 0, 0]) grip_ridges_wall_body();
}

// ridges only on the two ends of the longest side (the -X and +X walls)
module grip_ridges_all_walls_local() {
    grip_ridges_x_wall_local(0);
    grip_ridges_x_wall_local(1);
}

// half A: y <= 0, with tongue on the seam
module seam_half_a(bead_h) {
    intersection() {
        seam_solid();
        translate([-1, -200, -200]) cube([400, 200, 400]);
    }
    grip_ridges_all_walls_local();
    rotate([90, 0, 0]) mirror([0, 0, 1]) tongue_local(bead_h);
}

// half B: y >= 0, with groove on the seam
module seam_half_b(groove_half_width_mm = seam_groove_half_width_mm) {
    difference() {
        intersection() {
            seam_solid();
            translate([-1, 0, -200]) cube([400, 200, 400]);
        }
        rotate([90, 0, 0]) mirror([0, 0, 1]) groove_local(groove_half_width_mm);
    }
    mirror([0, 1, 0]) grip_ridges_all_walls_local();
}

label_size_mm = 9;
label_depth_mm = 0.6;              // engraved into the face on the bed, reads correctly from underneath

// engraved label on the bed face; mirrored so it reads correctly looking at the bed side
module bed_label(label, y_center_mm) {
    translate([box_length_mm / 2, y_center_mm, -0.01]) linear_extrude(label_depth_mm + 0.01) mirror([1, 0, 0])
        text(label, size = label_size_mm, halign = "center", valign = "center", font = "Liberation Sans:style=Bold");
}

module print_seam_a(bead_h = bead_height_mm, label = plate_labels[0]) {
    difference() {
        translate([0, 0, half_thickness_mm]) rotate([90, 0, 0]) seam_half_a(bead_h);
        bed_label(label, -box_height_mm / 2);
    }
}
module print_seam_b(label = plate_labels[0], groove_half_width_mm = seam_groove_half_width_mm) {
    difference() {
        translate([0, 0, half_thickness_mm]) rotate([-90, 0, 0]) seam_half_b(groove_half_width_mm);
        bed_label(label, box_height_mm / 2);
    }
}

// both halves pulled apart along the seam direction by gap_mm (0 = assembled)
module seam_pair(gap_mm) {
    color("tan") translate([0, -gap_mm / 2, 0]) seam_half_a(bead_height_mm);
    color("peru") translate([0, gap_mm / 2, 0]) seam_half_b();
}

module seam_closed() { seam_pair(explode_distance_mm); }
module seam_exploded() { seam_pair(max(explode_distance_mm, exploded_minimum_gap_mm)); }

module seam_assembly() {
    color("tan") print_seam_a();
    color("peru") translate([0, box_height_mm + 20, 0]) print_seam_b();
}

// all three bead heights, both halves, on one plate: rows = bead height, columns = half A / half B
module seam_plate() {
    for (i = [0 : len(plate_bead_heights_mm) - 1]) {
        translate([grip_ridge_protrusion_mm, i * plate_spacing_mm, 0]) {
            print_seam_a(plate_bead_heights_mm[i], plate_labels[i]);
            translate([box_length_mm + 6 + 2 * grip_ridge_protrusion_mm, 0, 0]) print_seam_b(plate_labels[i], plate_groove_half_widths_mm[i]);
        }
    }
}

if (part == "seam_a") print_seam_a();
else if (part == "seam_b") print_seam_b();
else if (part == "seam_closed") seam_closed();
else if (part == "seam_exploded") seam_exploded();
else if (part == "seam_assembly") seam_assembly();
else if (part == "seam_plate") seam_plate();
