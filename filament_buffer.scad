use <cylinders.scad>;

od = 60;
id = 56;
width = 14;
height = 14;
gear_dia = 54;
thickness = 3;
gap = 0.2;

full_guide ();
wheel(od, id, gear_dia, height, width);
wheel_mount ();

// guide_half();

module guide_half() {
  difference () {
    intersection() {
      rotate([90,90,180])
      translate([0,0,-20])
      guide();
      translate([-od/2-10,-width,-od/2-10])
      cube([od/2+10,od/2,od/2+10]);
    }
    translate([0,width/2+1,0])
    rotate([90,0,0])
    cylinder(r=od/2+gap, h=width+2, $fn=100);  
  }
}

module wheel(od, id, gear_dia, height, width) {
  translate([0, width/2,0])
  rotate([90,90,0]) {
    import("planetary.stl", convexity = 5);
    translate([0,0,0.2])
    hourglass(od, id, gear_dia, width-4.4, 2, fn=100);
    ring(od, id-2, height=0.201, fn=100);
    translate([0,0,width-0.201])
    ring(od, id-2, height=0.201, fn=100);
  }  
}

module full_guide () {
    union() {
      guide_half();
      // translate([-0.001,-width,0])
      rotate([0,0,180])
      guide_half();
    }
}


module guide () {
  translate([0,0,-1])
  difference() {
    translate([od/2-(od-id)/2,-od/2,width]) {
      translate([-od+thickness-1,0,0]) {
        translate([0,0,0]) 
        cube([thickness+od, od, width]);
      }
      
      // Retaining Ring
      translate([-od/2+2,od/2,0]) 
      intersection() {
        ring(od+5, od+gap*2, width, fn=100);
        translate([0,-od/2-3,0]) 
        cube([(od+6)/2, od+6, width+1]);
      }

    }
    // Filament Hole
    hull() {
      translate([od/2-5.4, 0,17.7]) 
      rotate([90,45,0])
      cube([4,4,0.1]);

      translate([od/2-3.2, od/2+4.9,17.7]) 
      rotate([90,45,0])
      cube([2.5,2.5,0.1]);
    }
  }
}

module wheel_mount () {
  translate([0,8,0]) {
    rotate([90,0,0]) 
    translate([0,0,width-0.11])
    cylinder(r=9, h=5, $fn=100);
    translate ([-9,-width-thickness,-od/2-thickness])
    cube ([18,3.1,thickness-gap]);
    hull () {
      translate ([-9,-5-width-thickness,-od/2-thickness])
      cube ([18,5,10]);
      rotate([90,0,0]) 
      translate([0,0,width+thickness])
      cylinder(r=9, h=5, $fn=100);
    }
  }
}
