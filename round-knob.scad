// A spherical knob for applications like covering the end of a bolt or handle.
// Size the hole smaller than what it will fit on, and drill or tap it to the exact size.

// Diameter of sphere
sphereDiameter = 30;

// Diameter of hole
holeDiameter = 11.5;

// Depth of hole
holeDepth = 18;

// Depth of flattening on hole side
flatDepth = 3;

// Assemble Rounded Knob

difference() {
// Sphere
        translate([0, 0, (sphereDiameter/2)-flatDepth]) {
                sphere(d = sphereDiameter,$fn=16);
        }
// Cut out
        translate([0,0,-flatDepth/2]){
                cylinder(h = flatDepth, d = sphereDiameter,center = true);
                translate([0,0,-flatDepth]){
                        cylinder(h = holeDepth+flatDepth, d = holeDiameter, center = false, $fn=100);
                }
        }
}

