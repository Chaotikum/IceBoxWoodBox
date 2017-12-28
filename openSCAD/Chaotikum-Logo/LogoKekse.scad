wW = 15;
rotate([0,0,180]) scale(.66)
union() {
// Cut 
  color([1,.5,0])
  linear_extrude(height = wW, convexity = 10)
  difference() {
    offset(delta=1) {
    union() {  
      import (file = "Parts/A-Base.dxf");
      import (file = "Parts/D-Feet.dxf");
    };
    };
    union() {  
      import (file = "Parts/A-Base.dxf");
      import (file = "Parts/D-Feet.dxf");
    };
}
linear_extrude(height = 0.3, convexity = 10)
difference() {
    union() {  
      import (file = "Parts/A-Base.dxf");
      import (file = "Parts/D-Feet.dxf");
    };
    offset(delta=-2) {
    union() {  
      import (file = "Parts/A-Base.dxf");
      import (file = "Parts/D-Feet.dxf");
    };
    };
}
}
// Top 
translate([66,0,0])
rotate([0,0,180]) scale(.66)
union() {
  color([1,.5,0])
  linear_extrude(height = 3, convexity = 10)
      import (file = "Parts/A-Base.dxf");
    linear_extrude(height = 3, convexity = 10)
        import (file = "Parts/D-Feet.dxf");
   linear_extrude(height=wW, convexity=10)
    union() {
      import (file = "Parts/B-holes.dxf");
      translate([58,46])
      text("C","Fira Sans",size=34,$fn=180);
    }
   linear_extrude(height=0.66*wW, convexity=10)
    difference() {
      import (file = "Parts/A-Base.dxf");
      offset(delta=-0.5)
      import (file = "Parts/A-Base.dxf");
    }
}
