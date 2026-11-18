// KINGrinder K6 replica (straight handle version). z = 0 is the bottom of the cup.
//
// SOURCES
//  - Body dims: "Hand Grinder v1" solids in Printables model 751697 (Yozer) STEP file:
//      cup d52 x 58, body d52, collar d54.5 (top 28mm, 2mm chamfer step), overall 170mm without handle.
//  - Overridden by hand measurement: overall 175.5, collar d54.6, full-diameter section 34.5 incl. plastic cap (3.6).
//  - Grip band / silver ring / collar split: measured off the official manual photo
//      (KINGrinder K6-EN.pdf), scaled so the cup matches the CAD cup height (58mm).
//  - 6.35mm (1/4") hex shaft: CAD hex circumradius 3.67mm.
//  - Handle: ESTIMATED from the manual photo proportions + 6.5mm rod seen in Printables 1295840 STEP.
//    No published handle dims found -- measure the real one and update the handle variables.
$fn = 96;

show_handle = true;
show_grinder_preview = true;              // other files that include this one set this to false to use only the modules and variables

// ---------- body, bottom to top ----------
total_height_mm = 175.5;                  // measured by hand, with the plastic cap

cup_height_mm = 58;
cup_diameter_mm = 52;

silver_ring_height_mm = 13.3;             // silver ring below the grip band
body_diameter_mm = 52;                    // silver ring, grip band and lower collar

grip_band_height_mm = 60.5;               // rubber grip band

collar_chamfer_height_mm = 2;             // chamfer from body diameter up to collar diameter
collar_diameter_mm = 54.6;                // measured by hand, widest part of the grinder
collar_full_diameter_height_mm = 34.5;    // measured by hand, INCLUDES the plastic cap
plastic_cap_height_mm = 3.6;              // measured by hand, ring showing on the outer edge at the very top
plastic_cap_skirt_diameter_mm = 45.3;     // measured by hand, the inner part of the cap that goes down into the grinder
plastic_cap_skirt_depth_mm = 4.6;         // measured by hand, how far it extends below the cap ring
plastic_cap_skirt_wall_mm = 1.5;          // ESTIMATE
cap_gasket_height_mm = 1.5;               // ESTIMATE: gasket around the skirt, right under the cap ring
cap_gasket_thickness_mm = 0.6;            // ESTIMATE: how far the gasket sticks out past the skirt

// silver collar below the chamfer, whatever is left of the total height (7.2)
collar_lower_height_mm = total_height_mm - (cup_height_mm + silver_ring_height_mm + grip_band_height_mm) - collar_chamfer_height_mm - collar_full_diameter_height_mm;

// ---------- top recess ----------
hopper_diameter_mm = 49;                  // recess at the top for the lid
hopper_depth_mm = 13.8;
hub_diameter_mm = 15.5;                   // hub in the bottom of the recess
hub_height_mm = 3.3;

lid_diameter_mm = 48;
lid_thickness_mm = 1.5;
lid_depth_below_rim_mm = 2;
lid_hole_diameter_mm = 13.5;              // the handle insert passes through this

hex_shaft_across_flats_mm = 6.5;          // measured by hand (a 1/4" hex would be 6.35)
hex_shaft_across_corners_mm = hex_shaft_across_flats_mm / cos(30);   // 7.51, what cylinder($fn = 6) takes as its diameter

// ---------- handle ----------
// exterior socket: the upright cylinder the arm comes off, sits on top of the grinder rim
handle_socket_diameter_mm = 15.4;         // measured by hand
handle_socket_height_mm = 10.1;           // measured by hand, the part visible outside the grinder
// insert: narrower cylinder on the same axis, goes down into the grinder through the lid hole, not visible
handle_insert_diameter_mm = 13.1;         // measured by hand
handle_insert_length_mm = 13;             // measured by hand, below the socket
handle_insert_groove_width_mm = 1.2;      // measured by hand
handle_insert_groove_offset_mm = 3;       // measured by hand, from the top of the insert (under the socket) down to the top of the groove
handle_insert_groove_depth_mm = 0.6;      // ESTIMATE
handle_socket_pocket_depth_mm = handle_insert_length_mm + 0.5;   // hex pocket in the insert, deep enough for the whole shaft
// arm, estimates
handle_rod_diameter_mm = 5;
handle_metal_end_to_end_length_mm = 140;  // measured by hand, whole metal handle stood upright (no ball): far edge of the socket to far edge of the bent end rod
handle_arm_length_mm = handle_metal_end_to_end_length_mm - handle_socket_diameter_mm / 2 - handle_rod_diameter_mm / 2;   // socket axis to bent end axis, 129.8
handle_bent_end_length_mm = 43.5;         // measured by hand, ball stub tip to the outer edge of the arm, parallel to the socket axis
handle_ball_diameter_mm = 40;             // measured
handle_ball_stub_diameter_mm = 4;         // measured by hand, the round tip
handle_ball_stub_length_mm = 3.3;         // measured by hand, neck plus tip, from the end of the rod
handle_ball_stub_neck_length_mm = 1;      // ESTIMATE: the groove between the end of the rod and the round tip
handle_ball_stub_neck_diameter_mm = 2.5;  // ESTIMATE
handle_ball_hole_clearance_mm = 0.2;      // ESTIMATE: extra diameter in the ball's hole so it clicks on

// handle heights, measured from the bottom of the socket (z = 0)
handle_rise_mm = handle_bent_end_length_mm - handle_ball_stub_length_mm - handle_rod_diameter_mm / 2;   // arm axis to the end of the bent end rod, 37.7
handle_arm_height_mm = handle_socket_height_mm / 2;                  // rod leaves the middle of the socket
handle_bent_end_top_z_mm = handle_arm_height_mm + handle_rise_mm;
handle_elbow_bend_radius_mm = 6;          // ESTIMATE: bend radius of the rod where the arm turns up into the bent end, measured to the rod centre line
handle_ball_center_height_mm = handle_bent_end_top_z_mm + handle_ball_diameter_mm / 2;   // ball rests on the end of the bent end

// ---------- exploded view ----------
explode_distance_mm = 30;                 // spacing between neighbouring parts when exploded, set to 0 for assembled

// ---------- derived heights ----------
collar_bottom_z_mm = cup_height_mm + silver_ring_height_mm + grip_band_height_mm;   // 131.8
top_rim_z_mm = total_height_mm;
lid_top_z_mm = top_rim_z_mm - lid_depth_below_rim_mm;

module cup() {
    color("darkgray") cylinder(d = cup_diameter_mm, h = cup_height_mm);
}

module ring() {
    color("silver") translate([0, 0, cup_height_mm]) cylinder(d = body_diameter_mm, h = silver_ring_height_mm);
}

module grip() {
    color("#2b3036") translate([0, 0, cup_height_mm + silver_ring_height_mm]) cylinder(d = body_diameter_mm, h = grip_band_height_mm);
}

// everything in the collar below the plastic cap
module collar() {
    chamfer_bottom_z = collar_bottom_z_mm + collar_lower_height_mm;
    full_diameter_bottom_z = chamfer_bottom_z + collar_chamfer_height_mm;
    color("dimgray") difference() {
        union() {
            translate([0, 0, collar_bottom_z_mm]) cylinder(d = body_diameter_mm, h = collar_lower_height_mm);
            translate([0, 0, chamfer_bottom_z]) cylinder(d1 = body_diameter_mm, d2 = collar_diameter_mm, h = collar_chamfer_height_mm);
            translate([0, 0, full_diameter_bottom_z]) cylinder(d = collar_diameter_mm, h = collar_full_diameter_height_mm - plastic_cap_height_mm);
        }
        translate([0, 0, top_rim_z_mm - hopper_depth_mm]) cylinder(d = hopper_diameter_mm, h = hopper_depth_mm + 0.1);
    }
    color("dimgray") translate([0, 0, top_rim_z_mm - hopper_depth_mm]) cylinder(d = hub_diameter_mm, h = hub_height_mm);
}

// separate plastic cap on top of the grinder (the twisting part), counted in collar_full_diameter_height_mm.
// ring showing at the top, skirt going down into the grinder, gasket around the skirt
module cap() {
    ring_bottom_z = top_rim_z_mm - plastic_cap_height_mm;
    color("black") translate([0, 0, ring_bottom_z]) difference() {
        cylinder(d = collar_diameter_mm, h = plastic_cap_height_mm);
        translate([0, 0, -0.1]) cylinder(d = hopper_diameter_mm, h = plastic_cap_height_mm + 0.2);
    }
    color("black") translate([0, 0, ring_bottom_z - plastic_cap_skirt_depth_mm]) difference() {
        cylinder(d = plastic_cap_skirt_diameter_mm, h = plastic_cap_skirt_depth_mm);
        translate([0, 0, -0.1]) cylinder(d = plastic_cap_skirt_diameter_mm - 2 * plastic_cap_skirt_wall_mm, h = plastic_cap_skirt_depth_mm + 0.2);
    }
    color("#3a3a3a") translate([0, 0, ring_bottom_z - cap_gasket_height_mm]) difference() {
        cylinder(d = plastic_cap_skirt_diameter_mm + 2 * cap_gasket_thickness_mm, h = cap_gasket_height_mm);
        translate([0, 0, -0.1]) cylinder(d = plastic_cap_skirt_diameter_mm - 1, h = cap_gasket_height_mm + 0.2);
    }
}

module lid() {
    color("darkslategray") translate([0, 0, lid_top_z_mm - lid_thickness_mm]) difference() {
        cylinder(d = lid_diameter_mm, h = lid_thickness_mm);
        translate([0, 0, -0.1]) cylinder(d = lid_hole_diameter_mm, h = lid_thickness_mm + 0.2);
    }
}

module shaft() {
    color("silver") translate([0, 0, top_rim_z_mm - hopper_depth_mm + hub_height_mm - 0.1])
        cylinder(d = hex_shaft_across_corners_mm, h = hopper_depth_mm - hub_height_mm + 0.1, $fn = 6);
}

// stub with a groove: narrow neck, then a round tip. base at z = 0 (sunk 0.1 mm so it fuses with what it sits on).
// grow = extra diameter, used for the matching hole in the ball
module ball_stub(grow = 0) {
    neck = handle_ball_stub_neck_length_mm;
    tip_d = handle_ball_stub_diameter_mm + grow;
    tip_center_z = handle_ball_stub_length_mm - tip_d / 2;
    translate([0, 0, -0.1]) cylinder(d = handle_ball_stub_neck_diameter_mm + grow, h = neck + 0.1);
    intersection() {
        translate([0, 0, tip_center_z]) sphere(d = tip_d);
        translate([0, 0, neck]) cylinder(d = tip_d + 1, h = tip_d);
    }
}

// rod of the handle in three pieces: straight arm, rounded elbow bend, straight bent end. origin = bottom of the socket.
// extensions lengthen the free ends (used by cutouts that need clearance past the ends)
module handle_arm_straight(rod_diameter_mm, arm_start_extension_mm = 0) {
    translate([-arm_start_extension_mm, 0, handle_arm_height_mm]) rotate([0, 90, 0])
        cylinder(d = rod_diameter_mm, h = arm_start_extension_mm + handle_arm_length_mm - handle_elbow_bend_radius_mm + 0.01);
}

// quarter turn from the arm (+X) up into the bent end (+Z). sweep_start_deg / sweep_angle_deg pick a slice of it (0 = arm side, 90 = bent end side)
module handle_elbow_bend(rod_diameter_mm, sweep_start_deg = 0, sweep_angle_deg = 90) {
    translate([handle_arm_length_mm - handle_elbow_bend_radius_mm, 0, handle_arm_height_mm + handle_elbow_bend_radius_mm])
        rotate([90, 0, 0]) rotate([0, 0, -90 + sweep_start_deg])
            rotate_extrude(angle = sweep_angle_deg) translate([handle_elbow_bend_radius_mm, 0]) circle(d = rod_diameter_mm);
}

module handle_bent_end_straight(rod_diameter_mm, bent_end_extension_mm = 0) {
    translate([handle_arm_length_mm, 0, handle_arm_height_mm + handle_elbow_bend_radius_mm - 0.01])
        cylinder(d = rod_diameter_mm, h = handle_rise_mm - handle_elbow_bend_radius_mm + bent_end_extension_mm + 0.01);
}

// metal handle. origin = bottom of the exterior socket, insert hangs below it (-z), bent end rises (+z)
module handle_metal() {
    color("silver") difference() {
        union() {
            cylinder(d = handle_socket_diameter_mm, h = handle_socket_height_mm);
            translate([0, 0, -handle_insert_length_mm]) cylinder(d = handle_insert_diameter_mm, h = handle_insert_length_mm);
            handle_arm_straight(handle_rod_diameter_mm);
            handle_elbow_bend(handle_rod_diameter_mm);
            handle_bent_end_straight(handle_rod_diameter_mm);
            translate([handle_arm_length_mm, 0, handle_bent_end_top_z_mm]) ball_stub();
        }
        // groove ring on the insert
        translate([0, 0, -handle_insert_groove_offset_mm - handle_insert_groove_width_mm]) difference() {
            cylinder(d = handle_insert_diameter_mm + 1, h = handle_insert_groove_width_mm);
            translate([0, 0, -0.1]) cylinder(d = handle_insert_diameter_mm - 2 * handle_insert_groove_depth_mm, h = handle_insert_groove_width_mm + 0.2);
        }
        // hex pocket that fits over the shaft
        translate([0, 0, -handle_insert_length_mm - 0.1]) cylinder(d = hex_shaft_across_corners_mm + 0.4, h = handle_socket_pocket_depth_mm + 0.1, $fn = 6);
    }
}

// wooden ball with a blind hole that clicks onto the stub
module handle_ball() {
    color("burlywood") difference() {
        translate([handle_arm_length_mm, 0, handle_ball_center_height_mm]) sphere(d = handle_ball_diameter_mm);
        translate([handle_arm_length_mm, 0, handle_bent_end_top_z_mm])
            ball_stub(handle_ball_hole_clearance_mm);
    }
}

module handle() {
    handle_metal();
    handle_ball();
}

// four pieces along the grinder axis, each moved up by its slot number times explode_distance_mm:
// body (cup, ring, grip, collar, shaft stay together), lid with its cap, handle, wooden ball
module grinder_body() {
    cup();
    ring();
    grip();
    collar();
    shaft();
}

module grinder_lid_with_cap() {
    cap();
    lid();
}

module grinder() {
    grinder_body();
    translate([0, 0, 1 * explode_distance_mm]) grinder_lid_with_cap();
    if (show_handle) translate([0, 0, top_rim_z_mm + 2 * explode_distance_mm]) {
        handle_metal();
        translate([0, 0, explode_distance_mm]) handle_ball();   // slides off the stub
    }
}

if (show_grinder_preview) grinder();
