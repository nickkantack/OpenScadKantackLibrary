
include <../RoundRectangle/RoundRectangle.scad>

$fa = 1;
$fs = 0.5;

board_width = 10;
board_length = 21;
board_height = 200;
dowel_radius = 5;
x_margin = 4;
y_shift = 10;
overlap = 0.1;

// color([1, .8, .3])
// wood();

color([.3, .3, .3])
block();

module wood(bonus = 0) {
 
    union() {
        // The two angled boards
        for (i=[-1:2:1]) {
        translate([i * board_width / 2, 0, 0])
        rotate([i * 50, 0, 0])
        round_rectangle([bonus + board_width, board_length, board_height], corner_radius = 2);
        }

        // The dowel
        rotate([0, 90, 0])
        cylinder(r=dowel_radius, h=board_height);
    }
    
}

module block() {
    
    difference() {
        translate([0, 0, y_shift])
        round_rectangle([2 * (x_margin + board_width), 2 * board_length, 2 * board_length], corner_radius = 2);
        
        wood(bonus = overlap);
        
        // Cuts
        for (i=[-1:2:1]) {
            translate([-i * board_width / 2, i * board_length, -board_length / 4])
            cube([overlap + board_width, board_length * 2, board_length], center=true);
        }
        
        // For dowel
        rotate([180, 0, 0])
        translate([board_width, -dowel_radius, 0])
        cube([x_margin * 2, dowel_radius * 2, 2 * y_shift]);
   }
    
}
