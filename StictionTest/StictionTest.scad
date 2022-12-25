
$fa = 1;
$fs = 0.5;

translate([0, 8, 0])
cylinder(r=2, h=8);

translate([0, -8, 0])
difference() {
    cylinder(r=8, h=3);
    cylinder(r=2.25, h=10, center=true);
}
