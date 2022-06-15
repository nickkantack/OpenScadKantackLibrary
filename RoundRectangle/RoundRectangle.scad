
$fs = 0.5;
$fa = 1;

module round_rectangle(dims, corner_radius) {
    difference() {
        cube(dims, center=true);
        for (i=[0:3]) {
            difference() {
                translate([(i % 2 - 0.5) * dims[0], (floor(i / 2) - 0.5) * dims[1], 0])
                cylinder(r=corner_radius, h=2 * dims[2], center=true);
                translate([(i % 2 - 0.5) * (dims[0] - 2 * corner_radius), (floor(i / 2) - 0.5) * (dims[1] - 2 * corner_radius), 0])
                cylinder(r=corner_radius, h=3 * dims[2], center=true);
            }
        }
    }
}
