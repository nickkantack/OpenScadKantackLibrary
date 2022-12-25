$fs = 0.5;
$fa = 1;

exaggeration = 0.5;

bot_thick_z = 12 + exaggeration / 2;
to_infinity = 40;
triangle_inset_y = 6;
triangle_inset_x = 18;
triangle_height_z = 4 - exaggeration / 2;
rubber_stopper_x = 20;
rubber_stopper_y = 1.5 + exaggeration / 2;
rubber_stopper_z = 0.5 + exaggeration / 2;
rubber_stopper_inset_y = 5;
triangle_back_apex_height_above_top = 5;
triangle_back_extension = 2.5 + exaggeration / 2;
port_height_z = bot_thick_z - triangle_height_z - exaggeration;
power_inset_y = 5;
power_plug_radius_addition = 0.75;
clip_margin = 2;

//color([0.7, 0.7, 0.7])
//laptop();



difference() {
    clip_positive();
    laptop();
    
        // Power plug reservation
        translate([10, power_inset_y, port_height_z])
        rotate([0, -90, 0])
        cylinder(r=(bot_thick_z - triangle_height_z) / 2 + power_plug_radius_addition, h=30);
    
    // Top shave
    translate([-5, -3, 10])
rotate([0, 90, 0])
linear_extrude(40)
polygon(points=[[-4, -5], [-4, 3], [7, -5]]);

    // Bottom shave
translate([-5, -3, 7])
rotate([0, 90, 0])
linear_extrude(40)
polygon(points=[[5, -5], [5, 3], [-9, -5]]);
    
    // top z shave
    translate([0, 0, 16])
    cube([100, 100, 5], center=true);

}

module laptop() {
    union() {
        // The body with taper cuts
        difference() {
            
            // The main block
            laptop_principal();
            
            // The cut on the bottom back of the laptop
            translate([0, 0, triangle_height_z])
            rotate([0, 90, 0])
            triangle([triangle_height_z, triangle_inset_y, to_infinity]);
            
            // The cut on the bottom right of the laptop
            mirror([1, 0, 0])
            translate([0, 0, triangle_height_z])
            rotate([0, 90, 90])
            triangle([triangle_height_z, triangle_inset_x, to_infinity]);
        }
        
        // The rubber stopper on top
        translate([0, rubber_stopper_inset_y, bot_thick_z])
        cube([rubber_stopper_x, rubber_stopper_y, rubber_stopper_z]);
        
        // USB-A reservation
        translate([0, 26.5, port_height_z - 4])
        mirror([1, 0, 0])
        cube([10, 13, 8]);
        
        // USB-C reservation
        
        // Triangle back
        rotate([0, 90, 0])
        linear_extrude(to_infinity)
        polygon(points=[[-triangle_height_z, 0], [-bot_thick_z, 0], [-triangle_height_z - triangle_back_apex_height_above_top, -triangle_back_extension]]);
    }
        
}

module laptop_principal() {
    cube([to_infinity, to_infinity, bot_thick_z]);
}

module clip_positive() {
    translate([0, 0, clip_margin])
    linear_extrude(bot_thick_z)
    polygon(points=[[-clip_margin, -triangle_back_extension - clip_margin], [30, -triangle_back_extension - clip_margin], [-clip_margin, 25]]);
}

module triangle(dims) {
    linear_extrude(dims[2])
    polygon(points=[[0, 0], [dims[0], 0], [dims[0], dims[1]]]);
}