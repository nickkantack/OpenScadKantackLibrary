
$fa = 1;
$fs = 0.5;

buoy_hullDims = [100, 120, 60];
buoy_hullShift = [0, 0, -10];
buoy_finDims = [60, 110, 150];
buoy_finShift = [0, 0, -20];

n = 20;
l = 30;
transition_height = 20;
sx = 40;
sy = 51;
ea = 40;
eb = 40 * 6 / 5;

// buoy_Buoy();

module bracket_transition() {
   
    
    points = [for (i=[0:8*n*l-1]) mixer(i)];
    
    within_circle_count = 8 * n;
    circle_count = l;
        
    faces = concat(
        [[for (i=[0:within_circle_count-1]) i]], // Front face
            
        [for (i=[0:circle_count-2]) for (j=[0:within_circle_count-1]) [i * within_circle_count + j, (i + 1) * within_circle_count + j, (i + 1) * within_circle_count + ((j + 1) >= within_circle_count ? 0 : j + 1), i * within_circle_count + ((j + 1) >= within_circle_count ? 0 : j + 1)]],
        
        [[for (i=[circle_count * within_circle_count:-1:(circle_count - 1) * within_circle_count]) i]] // Back face
    );

    polyhedron(points=points, faces = faces);
}


function mixer(i) = let(
    x = floor(i / 8 / n) / (l - 1),
    f = x == 1 ? 1 : 1 / (1 + exp(-8 * (x - 0.4)))
) f * square_point(i) + (1 - f) * ellipse_point(i);

function square_point(i) = let(
    si = i % (8 * n),
    x = si <= n ? -sx / 2 : si <= 3 * n ? ((si - n) / 2 / n - 0.5) * sx : si <= 5 * n ? sx / 2 : si <= 7 * n ? (0.5 - (si - 5 * n) / 2 / n) * sx : -sx / 2,
    y = si <= n ? sy / 2 * si / n : si <= 3 * n ? sy / 2 : si <= 5 * n ? sy * (0.5 - (si - 3 * n) / 2 / n) : si <= 7 * n ? -sy / 2 : sy * (-0.5 + (si - 7 * n) / 2 / n),
    z = floor(i / 8 / n) * transition_height / (l - 1)
) [x, y, z];
    
function ellipse_point(i) = let(
    si = i % (8 * n),
    theta = si * 360 / 8 / n,
    x = -ea * cos(theta),
    y = eb * sin(theta),
    z = floor(i / 8 / n) * transition_height / (l - 1)
) [x, y, z];
    


module smooth_base() {
    b = 30;
    f = 50;

    sigma1 = 0.2;
    sigma2 = 0.5;

    points = [for (i=[0:0.5:b]) [i, f * (1 - exp(-sigma1 * i)) * (1 - exp(sigma2 * (i - b)))]];
        
    scale([1, 6/5, 1])
    rotate_extrude(angle = 360, convexity = 2)
    rotate([0, 0, 90])
    polygon(points=points);
}

module buoy_Buoy() {
    union() {
        translate([0, 0, 10])
        union() {
            smooth_base();
            translate([0, 0, 10])
            rotate([180, 0, 0])
            bracket_transition();
        }
        translate([0, 0, 30])
        buoy_fin();
    }
}

module buoy_Buoy_no_fin() {
    union() {
        translate([0, 0, 10])
        union() {
            smooth_base();
            translate([0, 0, 10])
            rotate([180, 0, 0])
            bracket_transition();
        }
    }
}

module buoy_Buoy_just_fin() {
    union() {
        translate([0, 0, 30])
        buoy_fin();
    }
}

module buoy_hull() {
    rotate([180, 0, 0])
    buoy_cropped_ellipsoid(buoy_hullDims, buoy_hullShift);
}

module buoy_fin() {
    buoy_cropped_ellipsoid(buoy_finDims, buoy_finShift);
}

module buoy_cropped_ellipsoid(resize_vec, shift) {
    difference() {
        // Ellipsoid to make fin
        translate(shift)
        resize(resize_vec)
        sphere(r=10);
        // Crop the fin
        translate([-80, -80, -160])
        cube([160, 160, 160]);
    }
    
    // print the volume for reference
    // Print the volume for reference
    volume = 0;
    r = (resize_vec[0] + resize_vec[1]) / 4;
    a = resize_vec[2] / 2;
    a_minus_h = -shift[2];
    x_lim = r * sqrt(1 - a_minus_h * a_minus_h / a / a);
    for (x = [0:0.1:x_lim]) {
        // echo(2 * 3.14159 * x * a * (sqrt(1 - x * x / r / r) - a_minus_h / a) * 0.1);
    }
}