// Shapes made with cylinders

// Parameters used for all examples

id = 4;
od = 8;
height = 6;

od1 = 8;
od2 = 5;
id1 = 4;
id2 = 3;
height1 = 4;
height2 = 2;

fn = 20;

///////////////
// Examples
///////////////

// ring(od, id, height, fn);

// translate([0, od+2, 0])
// cone_ring(od1, od2, id1, id2, height, fn);

// translate([0, od*2+4, 0])
// single_taper_ring(od1, od2, id1, id2, height1 , height2, fn);

// translate([0, od*3+6, 0])
// double_taper_ring(od1, od2, id, height1 , height2, fn);

// translate([0, od*4+8, 0])
// hourglass(od1, od2, id, height1 , height2, fn);

// translate([0, od*4+12, 0])
// torus(8, 4, 20);

module ring(ring_od, ring_id, height, fn=50) {
  translate([0, 0, height/2])
  difference() {
    cylinder(r=ring_od/2, h=height, center=true, $fn=fn);
    cylinder(r=ring_id/2, h=height*1.01, center=true, $fn=fn);
  }
}

module cone_ring(od1, od2, id1, id2, height, fn=50) {
  translate([0, 0, height/2])
	difference() {
		cylinder(r1=od1/2,r2=od2/2, h=height, center=true, $fn=fn);
		cylinder(r1=id1/2,r2=id2/2, h=height+0.01, center=true, $fn=fn);
	}
}

module single_taper_ring(od1, od2, id1, id2, height1, height2, fn=50) {
  difference() {
    union() {
      ring(od1, 0, height1, fn);
      translate([0,0,height1-0.001])
      cone_ring(od1, od2, 0, 0, height2+0.001, fn);
      /*cone_ring(od1, od2, id1, id1, 3);*/
    }
    translate([0,0,-0.1])
    cylinder(r1=id1/2,r2=id2/2, h=(height1+height2)+0.2, $fn=fn);
  }
}

module double_taper_ring(max_od, min_od, id, height_center, height_cones, fn=50) {
    cone_ring(min_od, max_od, id, id, height_cones, fn);
    translate([0,0,height_cones-0.001])
    ring(max_od, id, height_center+0.002, fn);
    translate([0,0,height_center+height_cones])
    cone_ring(max_od, min_od, id, id, height_cones, fn);
}

module hourglass(max_od, min_od, id, height_center, height_cones, fn=50) {
    cone_ring(max_od, min_od, id, id, height_cones, fn);
    translate([0,0,height_cones-1])
    ring(min_od, id, height_center+2, fn);
    translate([0,0,height_center+height_cones])
    cone_ring(min_od, max_od, id, id, height_cones, fn);
}


module torus (torus_R, torus_r, fn_R=100, fn_r=20, rotation=0) {
  rotate_extrude($fn=fn_R)
  translate([torus_R, 0, 0])
  rotate([0,0,rotation]) // To adjust ring facets in cases where circle has few sides that need to align
  circle(r=torus_r, $fn=fn_r);
}
