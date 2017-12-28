wW = 15;
s=0.05;
rotate([0,0,180]) scale(1)
union() {
// Cut 
  color([1,.5,0])
  difference() {
    linear_extrude(height = wW, convexity = 10)
    difference() {
        offset(delta=1)
            shape();
        shape();
    };
    union() {
        for(l = [0:s:1]) {
        translate([0,0,wW-l])
        linear_extrude(height=s+s/2)
        offset(delta=1-l)
        shape();
    };
    };
};
// Top fun.
linear_extrude(height = 0.3, convexity = 10)
difference() {
    shape();
    offset(delta=-1) shape();
};
};
// Top 
translate([100,0,0])
rotate([0,0,180]) scale(1)
union() {
  color([1,.5,0])
  linear_extrude(height = 3, convexity = 10)
    shape();
  linear_extrude(height=wW, convexity=10)
  union() {
      rotate([180,0,0])
      translate([-65,-57.2,0])
      import (file = "Parts/B-Holes.dxf");
      rotate([0,180,180])
      translate([58-65,46-57.2])
      text("C","Fira Sans",size=34,$fn=180);
    }
   linear_extrude(height=0.66*wW, convexity=10)
    difference() {
      innerShape();
      offset(delta=-0.5)
      innerShape();
    }
}
module shape() {
  translate([-65,-57.2,0])
  union() {  
    import (file = "Parts/A-Base.dxf");
    import (file = "Parts/D-Feet.dxf");
  };
}
module innerShape() {
      translate([-65,-57.2,0])
  union() {  
    import (file = "Parts/A-Base.dxf");
  };
}

