
include <../EfficientCube/EfficientCube.scad>

$fa = 1;
$fs = 0.5;

ground_thickness = 3;
wiring_gap = 30;

// relay rack base
efficient_cube([50, 33.5 * 5 + 6, ground_thickness], center=true);

// posts for relays
for (i=[-5:2:5]) {
    translate(i * [0, 33.5/2, 0])
    cube([50, 3, ground_thickness], center=true);
    for (j=[-1:2:1]) {
        translate([j * 22, i * 33.5/2, 0])
        cylinder(r=2.5/2, h=5 + (abs(i) < 4 ? 20 : 0));
    }
}

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
