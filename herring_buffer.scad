use <../../libraries/cylinders.scad>;

od = 60;
id = 56;
width = 14;
height = 14;
gear_dia = 54;
thickness = 3;
gap = 0.2;

rotate([90,90,0])
wheel(od, id, gear_dia, height, width);

full_guide ();

wheel_mount ();
module guide_half() {

  intersection() {
    rotate([90,90,180])
    translate([0,0,-20])
    guide();
    translate([-od/2-10,-width,-od/2-10])
    cube([od/2+10,od/2,od/2+10]);
  }
}

module wheel(od, id, gear_dia, height, width) {
  import("planetary.stl", convexity = 5);
  translate([0,0,0.2])
  hourglass(od, id, gear_dia, width-4.4, 2, fn=100);
  ring(od, id-2, height=0.201, fn=100);
  translate([0,0,width-0.201])
  ring(od, id-2, height=0.201, fn=100);
  
}

module full_guide () {
  difference () {
    union() {
      guide_half();
      translate([-0.001,-width,0])
      rotate([0,0,180])
      guide_half();
    }
    rotate([90,0,0])
    translate([0,0,-1])
    cylinder(r=od/2+gap, h=width+2, $fn=100);  
  }
}


module guide () {
  difference() {
    translate([od/2-(od-id)/2,-od/2,width]) {
      translate([gap,0,0]) {
        translate([(od-id)/2,0,0]) 
        cube([thickness-gap, od, width]);
        translate([-2.2,od,7.7]) 
        rotate([90,45,0])
        cube([2.3*1.414,2.3*1.414,od/2+5]);
        translate([0.1,od,0]) 
        rotate([90,0,0])
        cube([2.3,width,od/2+5]);
            
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
    translate([od/2-2.6, od/2+4.9,17.7]) 
    rotate([90,45,0])
    cube([2,2,od/2+5]);
  }
}

module wheel_mount () {
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
