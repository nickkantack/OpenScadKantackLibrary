
$fs = 0.5;
$fa = 1;

/*
This allows easy replacement
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
