
$fa = 1;
$fs = 0.5;

difference() {

    union() {

        linear_extrude(height = 10, convexity = 10, slices = 20, scale = 4.5/4, $fn = 32)
        circle(r=2);

        translate([0, 0, 10])
        cylinder(r=3, h=3);

        translate([0, 0, 10 + 3])
        linear_extrude(height = 15, convexity = 10, slices = 20, scale = 7/8, $fn = 32)
        circle(r=4);

    }
    
    translate([0, 0, -1])
    cylinder(r=1.25, h=30);

}