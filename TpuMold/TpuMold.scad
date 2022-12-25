
include <../Spiral/Spiral.scad>

$fa = 1;
$fs = 0.5;

mold();

// fake wire
color([0.4, 1, 0.4])
translate([0, -21, 19])
rotate([90, 0, 0])
cylinder(r=0.8, h=20, center=true);

color([0.4, 1, 0.4])
translate([0, 21, 19])
rotate([90, 0, 0])
cylinder(r=0.8, h=20, center=true);

color([0.4, 1, 0.4])
translate([0, -11, 15])
rotate([0, -90, 0])
spiral(4, 0.8, 0, 0.25);

color([0.4, 1, 0.4])
translate([0, 11, 15])
rotate([0, 0, 180])
rotate([0, -90, 0])
spiral(4, 0.8, 0, 0.25);

color([0.2, 0.2, 0.2])
translate([0, 0, 14])
rotate([90, 0, 0])
cylinder(r=4, h=14, center=true);


module mold() {
    difference() {
        translate([0, 0, 10])
        cube([40, 40, 20], center=true);
        
        translate([0, 0, 10])
        rotate([90, 0, 0])
        cylinder(r=8, h=20, center=true);
        
        translate([0, 0, 20])
        cube([16, 20, 20], center=true);
        
        translate([0, -13, 19])
        curve_cut();
        
        translate([0, 13, 19])
        rotate([0, 0, 180])
        curve_cut();
    }
}

module curve_cut() {
    union() {
        translate([0, 0, -4])
        for (i=[0:0.5:2]) {
            translate([0, 0, i])
            rotate([0, -90, 0])
            spiral(4, 1, 0, 0.25);
        }
        
        translate([0, 0.1, 0])
        rotate([90, 0, 0])
        cylinder(r=1, h=10);
        
        translate([0, -4.8, 2])
        cube([2, 10, 4], center=true);
    }
}
