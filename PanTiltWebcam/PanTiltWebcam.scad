
include <../Gear/Gear.scad>

$fs = 0.5;
$fa = 1;

hinge_height = 20;
axel_radius = 2.5;
axel_radial_margin = 0.25;
square_margin = 0.25;
shaft_margin = 0.1;

rotate([0, 90, 0])
stepper_motor();

tilt_bracket();

tilt_platform();

tilt_axel();

square_tilt_gear();

round_tilt_gear();

gear_base();

module tilt_bracket() {
    
    union() {
        
        // brace for screws
        difference() {
            color([1, 0, 0])
            translate([0, 0, 31/2 + 2])
            translate([20.6 + 1, 0, 0])
            cube([2, 42, 11], center=true);
            
            // Cutout to save some material
            translate([0, 0, 31/2])
            translate([18, 0, 0])
            cube([12, 20, 10], center=true);
            
            // screw holes
            for (i=[-1:2:1]) {
                translate([20.5, i * 31/2, 31/2])
                rotate([0, 90, 0])
                cylinder(r=1.5, h=10, center=true);
            }
            
        }
        
        // Top base
        difference() {
            color([1, 0, 0])
            translate([0, 0, 1 + 21])
            efficient_cube([42, 42, 2], center=true, thickness=5);
        }
        
        // Axle supports
        for (i=[-1:2:1]) {
            difference() {
                // Supports (without cut for axel)
                union() {
                    
                    color([1, 0, 0])
                    translate([18.5 * i, 0, hinge_height / 2 + 21 + 2])
                    cube([5, 10, hinge_height], center=true);
                    
                    color([1, 0, 0])
                    translate([18.5 * i, 0, hinge_height + 21 + 2])
                    rotate([0, 90, 0])
                    cylinder(r=5, h=5, center=true);
                }
                
                // Cut for axel
                translate([18.5 * i, 0, 21 + 2 + hinge_height])
                rotate([0, 90, 0])
                cylinder(r=axel_radius + axel_radial_margin, h=8, center=true);
            }
        }
    }
}


module tilt_platform() {
    
    union() {
        
        // main base
        translate([0, 0, 31.5 + hinge_height])
        efficient_cube([30, 50, 3], thickness=3, center=true);
        
        for (i=[-1:2:1]) {
            
            // Hinge
            // circular portion
            translate([0, 0, 23 + hinge_height])
            rotate([0, 90, 0])
            difference() {
                
                union() {
                    
                    // cube portion
                    translate([-5, 0, 0])
                    cube([10, 10, 30], center=true);
                    
                    // The hinge wall
                    cylinder(r=5, h=31, center=true);
                }
                
                // The hinge hole
                cylinder(r=axel_radius + axel_radial_margin, h=50, center=true);         
            } 
        }
    }
}

module tilt_axel() {
    color([0.5, 0.5, 1])
    union() {
        
        // Main shaft
        translate([0, 0, 23 + hinge_height])
        rotate([0, 90, 0])
        cylinder(r=axel_radius, h=47, center=true);
        
        // Round cap
        translate([-23, 0, 23 + hinge_height])
        rotate([0, 90, 0])
        cylinder(r=axel_radius * 2, h=3, center=true);
        
        // Square part
        translate([25 + 2, 0, 23 + hinge_height])
        cube([axel_radius * 2 + 4, axel_radius * 2, axel_radius * 2], center=true);
    }
}

module square_tilt_gear() {
    color([0.5, 1, 0.5])
    translate([27, 0, 23 + hinge_height])
    rotate([0, 90, 0])
    difference() {
        efficient_gear(tooth_height=2, mid_tooth_radius=30, inner_cut_radius=26, inner_keep_radius=6, slat_thickness=3, modes=4, height=4);
        // square cut
        cube([(axel_radius + square_margin) * 2, (axel_radius + square_margin) * 2, 2], center=true);
    }
}

module round_tilt_gear() {
    color([0.5, 1, 0.5])
    union() {
        translate([27, 0, 0])
        rotate([0, 90, 0])
        difference() {
            gear(tooth_height=2, mid_tooth_radius=12.7, height=4);
            // shaft cut
            cylinder(r=5/2 + shaft_margin, h=5, center=true);
        }
      
        // notch on shaft
        translate([27, 0, -1 -2])
        cube([4, 8, 2], center=true);
    }
}
    

module gear_base() {
    
    color([0.5, 1, 1])
    union() {
        
        // Bottom platform gear and box
        translate([0, 0, -21])
        union() {
            // gear
            difference() {
                // the gear without the track
                efficient_gear(tooth_height=2, mid_tooth_radius=50, inner_cut_radius=35, inner_keep_radius=0, slat_thickness=3, modes=4, height=4);
                
                // Track for bottom base posts
                translate([0, 0, -3.5])
                ring_blade(height=4, thickness=8, mid_radius=42.5);
            }
            
            // box
            efficient_cube([42, 42, 4], center=true, thickness=5);
            
            // Outer rail guard
            translate([0, 0, -2.5])
            difference() {
                cylinder(r=48, h=5, center=true);
                cylinder(r=45, h=6, center=true);
            }
            
            // Inner rail guard
            translate([0, 0, -2.5])
            difference() {
                cylinder(r=40, h=5, center=true);
                cylinder(r=37, h=6, center=true);
            }
            
        }
        
        // Brace for screws
        difference() {
            translate([0, 0, -31/2 - 2])
            translate([20.6 + 1, 0, 0])
            cube([2, 42, 11], center=true);
            
            // Cutout to save some material
            translate([0, 0, -31/2 + 1.5])
            translate([18, 0, 0])
            cube([12, 20, 10], center=true);
            
            // screw holes
            for (i=[-1:2:1]) {
                translate([20.5, i * 31/2, -31/2])
                rotate([0, 90, 0])
                cylinder(r=1.5, h=10, center=true);
            }
            
        }
    }
}

module ring_blade(height, thickness, mid_radius) {
    
    rotate_extrude()
    polygon(points=[[mid_radius - thickness / 2, 0], [mid_radius, height], [mid_radius + thickness/2, 0]]);
    
}

module stepper_motor() {
    difference() {
        // Main cube body
        union() {
            // Grey
            color([0.6, 0.6, 0.6])
            cube([42, 42, 41], center=true);
            
            // Black
            color([0.2, 0.2, 0.2])
            cube([42.1, 42.1, 20], center=true);
            
            // Motor lip
            difference() {
                color([0.6, 0.6, 0.6])
                translate([0, 0, 20.5])
                cylinder(r=11, h=2.5);
                
                // Big cutout for shaft
                translate([0, 0, 20.6])
                cylinder(r=5, h=3);
            }
            
            // Shaft
            difference() {
                color([0.9, 0.9, 0.9])
                translate([0, 0, 20.5-3])
                cylinder(r=2.5, h=23);
                
                translate([2, -5, 20.5 + 2.5 + 2])
                cube([10, 10, 18]);
            }
            
            // Lip near cables
            color([0.6, 0.6, 0.6])
            translate([-8, 21, -20.5])
            cube([16, 4, 4.3]);
            
            // Cable plastic
            color([0.9, 0.8, 0.6])
            translate([-8, 21, -20.5 + 4.31])
            cube([16, 6.7, 6.7]);
        }
        
        // Corners
        for (i=[0:3]) {
            rotate([0, 0, 45 + i * 90])
            translate([27, -10, -25])
            cube([20, 20, 50]);
        }
        
        // Screw holes
        for (i=[-1:2:1]) {
            for (j=[-1:2:1]) {
                translate([31/2 * i, 31/2 * j, 20.5 - 5])
                cylinder(r=1.5, h=6);
            }
        }
    }
}


/*
This is a very valuable module. It allows easy replacement
of a solid cube with one that has lots of area cut away
yet it maintains a great deal of shear and tensile strength.

This is a drop-in replacement for cube();
*/
module efficient_cube(dims, center=false, thickness=2) {
    
    translation_vector = center ? [0, 0, 0] : dims / 2;
    
    translate(translation_vector)
    union() {
        
        // Border
        difference() {
            cube(dims, center=true);
            cube(dims - [thickness * 2, thickness * 2, -thickness], center=true);
        }
        
        // Slats
        difference() {
            
            slat_length = sqrt(pow(dims[0] - thickness / 2, 2) + pow(dims[1] - thickness / 2, 2));
            slat_angle = atan((dims[0] - thickness / 2)/(dims[1] - thickness / 2));
            
            // Untrimmed slats
            union() {
                for (i=[-1:2:1]) {
                    rotate([0, 0, i * slat_angle])
                    cube([thickness, slat_length, dims[2]], center=true);
                }
            }
            
            // Boundary cuts
            union() {
                for (i=[-1:2:1]) {
                    translate([(dims[0] - 0.1) * i, 0, 0])
                    scale([1, 1, 1.2])
                    cube(dims, center=true);
                }
                for (i=[-1:2:1]) {
                    translate([0, (dims[1] - 0.1) * i, 0])
                    scale([1, 1, 1.2])
                    cube(dims, center=true);
                }
            }
        }
    }
}