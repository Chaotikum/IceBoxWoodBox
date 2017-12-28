wW = 4;

color([0,0,0])
translate([-130,-45,-wW/8])
    cube([130,45, wW/8]);
rotate([0,0,180]) scale(.4)
union() {
  color([1,.5,0])
  linear_extrude(height = 4*wW, convexity = 10)
    difference() {
      import (file = "Parts/A-Base.dxf");
      import (file = "Parts/B-holes.dxf");
      translate([58,46])
      text("C","Fira Sans",size=34,$fn=180);
    }
    color([.5,.5,.5])
linear_extrude(height = 2*wW, convexity = 10)
   import (file = "Parts/D-Feet.dxf");
color([1,1,1])
translate([210,46])
   linear_extrude(2*wW)
        text("haotikum",font="Fira Sans",size=34,halign="center",valing="center",$fn=180);
   translate([305,12])
   color([.5,.5,.5])
   linear_extrude(wW)
//        text("chaotikum.org",font="Fira Sans",size=16,halign="right",valing="center");
        text(".org",font="Fira Sans",size=16,halign="right",valing="center",$fn=180);
}