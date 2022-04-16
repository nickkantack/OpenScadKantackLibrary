
$fs = 0.5;
$fa = 1;

rotate([0, 90, 0])
stepper_motor();

tilt_bracket();

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
            cube([42, 42, 2], center=true);
        }
        
        // Axle supports
        for (i=[-1:2:1]) {
            difference() {
                // Supports (without cut for axel)
                union() {
                    
                    color([1, 0, 0])
                    translate([18.5 * i, 0, 5 + 21 + 2])
                    cube([5, 10, 10], center=true);
                    
                    color([1, 0, 0])
                    translate([18.5 * i, 0, 5 + 21 + 2 + 5])
                    rotate([0, 90, 0])
                    cylinder(r=5, h=5, center=true);
                }
                
                // Cut for axel
                translate([18.5 * i, 0, 5 + 21 + 2 + 5])
                rotate([0, 90, 0])
                cylinder(r=3, h=8, center=true);
            }
        }
       
        
    }
    
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