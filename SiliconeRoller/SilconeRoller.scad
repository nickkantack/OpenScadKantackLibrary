
$fa = 1;
$fs = 0.5;

height = 8;
length = 40;

union() {
    
    difference() {
        
        cylinder(r=6, h=height);
        
        translate([0, 0, -1])
        cylinder(r=4, h=height * 2);
        
    }
    
    translate([-4, 4, 0])
    cube([8, length, height]);
    
    translate([0, length + 8, 0])
    difference() {
        
        cylinder(r=6, h=height);
        
        translate([0, 0, -1])
        cylinder(r=4, h=height * 2);
        
    }
    
}
