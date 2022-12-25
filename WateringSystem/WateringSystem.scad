
include <../EfficientCube/EfficientCube.scad>
include <../Screws/Screws.scad>

$fa = 1;
$fs = 0.5;

ground_thickness = 3;
wiring_gap = 30;

difference() {
    translate([0, 0, 1])
    cylinder(r=4, h=4);
    M5(10, forCut = true);
}

translate([8, 0, 1])
M5(4, forCut = false);

/*
// relay rack base
efficient_cube([50, 33.5 * 5 + 6, ground_thickness], thickness=3, center=true);

// joiner for interface board braces
translate([wiring_gap / 2 + 50 / 2, 0, 0])
efficient_cube([wiring_gap, 105, 3], center=true);

// braces
translate([wiring_gap + 50 / 2 - 3, 0, -ground_thickness/2])
for (i=[0:1]) {
    rotate([0, 0, 180 * i])
    translate([0, -101/2, 0])
    difference() {
        translate([-2.5, -2, 0])
        cube([5, 4, 30]);
        translate([-1, 0, -0.5])
        cube([2, 3, 32]);
    }
}

// slanted supports
translate([wiring_gap / 2 + 50 / 2 + 4.5, 0, 13])
for (i=[0:1]) {
    rotate([0, 30, 0])
    rotate([0, 0, 180 * i])
    translate([0, -103/2, 0])
    cube([5, 2, 30], center=true);
}

// front bottom removable rail for relays
translate([-6, 0, 0])
difference() {
    cube([16, 105, 6], center=true);
    translate([8 - 0.5, 0, 0])
    cube([3, 106, 2], center=true);
}
*/