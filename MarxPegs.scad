
$fa = 1;
$fs = 0.5;

a = 60;
rp = 1.5;
R = 5 + rp / sin(a / 2);

cylinder(r=R + rp, h=2);

for (i=[0:8]) {
    rotate([0, 0, a * i + a / 2])
    translate([R, 0, 0])
    cylinder(r=rp * .8, h=10);
}
/*
color([0, 0, 1])
rotate([0, 0, a / 2])
translate([0, 0, 8])
cube([5, 20, 0.4], center=true);

color([0, 0, 1])
rotate([0, 0, a + a / 2])
translate([0, 0, 8])
cube([5, 20, 0.4], center=true);

color([0, 0, 1])
translate([0, 0, 8])
cylinder(r=5, h=0.4, center=true);
*/