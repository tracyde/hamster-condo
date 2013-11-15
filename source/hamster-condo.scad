num = 10;
radius = 65;
wall = 3;

module chunkyHouse(r, wall) {
	difference() {
		baseSphere(r, wall);
		door(r, wall);
		holes(r = 65, wall = 3, num = num);
	}
}

module baseSphere(r, wall) {
	difference() { // cut off the bottom
		union() {
			translate([0,0,r/2])
				emptySphere(r, wall);
			difference() {
				linear_extrude(height = wall)
					circle(r+wall);
				sphere(r-(wall*2+4), center = true);
			}
		}
		translate([0,0,-r/2])
			cube(size = [r*2+1, r*2+1, r], center = true);
	}
}

module emptySphere(r, wall) {
	difference() {
		union() {
			sphere(r);
			decor(r, wall, num);
		}
		sphere(r-wall);
	}
}

module door(r, wall) {
	translate([0,r,10])
		rotate(a = [90,0,0]) {
			cylinder(h = r, r = r/2.5, center = true);
		}
}

module holes(r, wall, num) {
	cylinder(h = r*3, r = r/2, center = true);
	translate([0, 0, r])
		for ( i = [0 : num-1] ) {
			rotate( a = i * 360 / num, v = [0, 0, 1])
		    translate([0, r/1.2, 0])
		    sphere(r = wall*2.5);
		}
}

module decor(r, wall, num) {
	translate([0, 0, r/5])
		for ( i = [0 : num-1] ) {
			rotate( a = i * 360 / num, v = [0, 0, 1])
		    translate([0, r*0.95, 0])
		    sphere(r = wall*2.5);
		}
}

chunkyHouse(r = radius, wall = wall);