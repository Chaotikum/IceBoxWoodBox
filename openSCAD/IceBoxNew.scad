
/*
 *    Measurements – all refer to _outer_ measurements
 */
displayWidth = 170; //Width of the display-Slot
displayHeight = 110; //Hewigh of the Display-Slot
displayBorder = 20; //Border around the display
depth = 70;  // Depth behind end of upper end of display plate
height = 70; // Height below display plate
iBHeight = 100; //inner Box Height
iBDepth = 40; //Inner Box depth
slotWidth = 40;
slotDepth = 7.5;
wW = 4;
cRadius = 20;

/*
 * Vizuals
 */
flat = true;
spacing = 0*wW;

//Dont change these values 251 230 85
FrontHeight = displayHeight+2*displayBorder;
sideHeight = FrontHeight*sin(60);
sideDepth = FrontHeight*cos(60);
width = displayWidth+2*displayBorder;
tDepth = depth+sideDepth;
tHeight = sideHeight+height;

trB = flat ? [0,0,0] : [0,0,-spacing+wW/2];
color([0.26700401, 0.00487433, 0.32941519])
translate(trB)
    bottomPlate();
trF = flat ? [0,tDepth/2+height/2+spacing-wW,0] : [0,tDepth/2+spacing-wW/2,height/2];
rotF = flat ? [0,0,0] : [90,0,00];
color([0.99324789, 0.90615657, 0.1439362])
translate(trF) rotate(rotF)
    frontPlate("icebox.nobreakspace.org","Fira Sans",12); 

trS1 = flat ? [width+spacing,0] : [width/2+spacing-wW/2,0,tHeight/2];
rotS1 = flat ? [0,0,0] : [0,-90,0];
color([0.12872938, 0.56326503, 0.55122927])
translate(trS1) rotate(rotS1)
sidePlate();

trS2 = flat ? [-width-spacing,0] : [-width/2-spacing+wW/2,0,tHeight/2];
rotS2 = flat ? [0,180,0] : [0,-90,0];
color([0.12872938, 0.56326503, 0.55122927])
translate(trS2) rotate(rotS2)
sidePlate();

trR = flat ? [0,-tHeight/2-tDepth/2-spacing,0] : [0,-tDepth/2+wW/2-spacing,tHeight/2];
rotR = flat ? [0,0,0] : [90,0,0];
color([0.36074053, 0.78596419, 0.38781353])
translate(trR) rotate(rotR)
rearPlate();

trT = flat ? [0,-3*depth/2-tHeight-wW-2*spacing,0] : [0,-depth/2-wW+1.5,tHeight-wW/2+spacing];
rotT = flat ? [0,0,0] : [0,0,0];
color([0.15389405, 0.68020343, 0.50417217])
translate(trT) rotate(rotT)
topPlate("Spenden und Getränkekasse","Fira Sans",10);

trD = flat ? [0,FrontHeight/2+depth+height+2*spacing,0] : [0,-.9+sideDepth/2-(wW-spacing)*sin(60),.9+tHeight-sideHeight/2-(wW-spacing)*cos(60)];
rotD = flat ? [0,0,0] : [120,0,0];
#color([0.66805369, 0.86199932, 0.19629307])
translate(trD) rotate(rotD)
displayPlate();

triB = flat ? [width+wW+spacing,-tDepth/2+spacing+iBDepth/2+2*wW] : [0,0,tHeight-iBHeight-wW/2-spacing];
rotiB = flat ? [0,0,0] : [0,0,0];
color([0.27957399, 0.17059884, 0.47999675])
translate(triB) rotate(rotiB)
innerBottomPlate();

triF = flat ? [width+spacing,-tDepth/2+2*spacing-iBDepth-iBHeight/2-2*wW] 
    : [0,-depth+iBDepth-wW-0.5+spacing,tHeight-iBHeight/2-wW/2];
// Also looking for this half a mm offset :/
rotiF = flat ? [0,0,0] : [90,0,0];
color([0.2316735, 0.3181058, 0.54483444])
translate(triF) rotate(rotiF)
innerFrontPlate();

trK = flat ? [-width-spacing,-iBHeight-2*displayBorder-spacing,0] : [0,-13-tDepth/2+wW/2-spacing,tHeight/2+iBHeight/2-displayBorder];
rotK = flat ? [0,0,0] : [120,0,0];
color([0.36074053, 0.78596419, 0.38781353])
translate(trK) rotate(rotK)
Klappe(hole=true);

/* Klappe */
module Klappe(hole=false,extr=wW) {
    linear_extrude(extr,center=true)
    difference() {
        hull() {
            square([width-2*displayBorder,iBHeight-2*displayBorder-cRadius],center=true);
            translate([width/2-displayBorder-cRadius,iBHeight/2-wW-displayBorder/2])
            circle(cRadius);
            translate([-width/2+displayBorder+cRadius,iBHeight/2-wW-displayBorder/2])
            circle(cRadius);
        };
        if (hole)
           translate([0,iBHeight/2-wW-displayBorder/2-cRadius/2,0]) circle(2*cRadius/3);
    }
}
/* inner Front plate */
module innerFrontPlate() {
    linear_extrude(wW,center=true)
    polygon(points = concat( // shorten all first and last lines
//  [[-width/2, tDepth/2],  [width/2, height/2]], //Topr:
    genSide(0,[0,iBHeight/2-wW/2],width,2,wW,wW,wW),
//    [[width/2,  height/2],  [width/2,-height/2]], // left (seen from front)
    genSide(90,[width/2-wW,0],iBHeight-wW,2,wW,wW,wW),
//    [[width/2, -height/2], [-width/2,-height/2]], // bottom
    genSide(180,[0,-iBHeight/2-wW/2],width,5,-wW,wW,wW),
//    [[-width/2,-height/2], [-width/2, height/2]] // right
    genSide(270,[-width/2+wW,0],iBHeight-wW,2,wW,2*wW,2*wW)
    ));
}
/* inner Bottom plate */
module innerBottomPlate() {
    linear_extrude(wW,center=true)
    polygon(points = concat(
//    [[-width/2,-tDepth/2+iBDepth],[width/2,-tDepth/2+iBDepth]],    //front
    genSide(0,[0,-tDepth/2+iBDepth-wW],width,5,wW,wW,wW),
//    [[width/2,-tDepth/2+iBDepth],[width/2,-tDepth/2]], // left
    genSide(90,[width/2-wW,-tDepth/2+iBDepth/2],iBDepth,1,wW,wW,wW),
//    [[width/2,-tDepth/2],[-width/2,-tDepth/2]], //back
    genSide(180,[0,-tDepth/2+wW],width,2,wW,wW,wW),
//    [[-width/2,-tDepth/2],[-width/2,-tDepth/2+iBDepth]] //right
    genSide(270,[-width/2+wW,-tDepth/2+iBDepth/2],iBDepth,1,wW,wW,wW)
    ));
}
/* Display Plate */
module displayPlate() {
    difference() {
    linear_extrude(wW,center=true)
polygon(points = concat( // shorten all first and last lines
//  [[-width/2, tDepth/2],  [width/2, tDepth/2]], //Front:
    genSide(0,[0,FrontHeight/2-wW*cos(60)],width,8,-wW,wW,wW),
//    [[width/2,  tDepth/2],  [width/2,-tDepth/2]], // left (seen from front)
    genSide(90,[width/2-wW,0],FrontHeight,2,wW,wW,wW),
//    [[width/2, -tDepth/2], [-width/2,-tDepth/2]], // rear
    genSide(180,[0,-FrontHeight/2+wW],width,0,wW,wW,wW),
//    [[-width/2,-tDepth/2], [-width/2, tDepth/2]] // right
    genSide(270,[-width/2+wW,0],FrontHeight,2,wW,wW,wW)
    ));
      cube([displayWidth,displayHeight,1.1*wW], center=true);
    }
}
    
/* top plate */
module topPlate(textStr,fontStr,size) {
difference () {
    linear_extrude(wW,center=true)
    polygon(points = concat( // shorten all first and last lines
//  [[-width/2, depth/2],  [width/2, depth/2]], //Front:
    genSide(0,[0,depth/2-wW*cos(60)],width,8,wW,wW,wW),
//    [[width/2,  tDepth/2],  [width/2,-tDepth/2]], // left (seen from front)
    genSide(90,[width/2-wW,0],depth,2,wW,wW,wW),
//    [[width/2, -tDepth/2], [-width/2,-tDepth/2]], // rear
    genSide(180,[0,-depth/2],width,2,-wW,wW,wW),
//    [[-width/2,-tDepth/2], [-width/2, tDepth/2]] // right
    genSide(270,[-width/2+wW,0],depth,2,wW,wW,wW)
    ));
    linear_extrude(1.1*wW,center=true)
    polygon(points=genSide(0,[0,1],width,2,wW,0,0));
    translate([0,-depth/2+iBDepth/2+wW/2])
    cube([slotWidth,slotDepth,1.1*wW],center=true);
  }
  translate([0,iBDepth/1.75,wW/2])
  linear_extrude(wW,center=true)
  rotate([0,0,180])
  text(textStr,fontStr,size=size,halign="center",valing="center");
}

/* back plate */
module rearPlate() {
  difference() {
  linear_extrude(wW,center=true)
    polygon(points = concat( // shorten all first and last lines
//  [[-width/2, -tHeight/2],  [width/2, tHeight/2]], //Top:
    genSide(0,[0,tHeight/2-wW],width,2,wW,wW,wW),
//    [[width/2,  tHeight/2],  [width/2,-tHeight/2]], // left (seen from front)
    genSide(90,[width/2-wW,0],tHeight,4,wW,0,0),
//    [[width/2, -tHeight/2], [-width/2,-tHeight/2]], // bottom
    genSide(180,[0,-tHeight/2],width,2,-wW,0,0),
//    [[-width/2,-tHeight/2], [-width/2, tHeight/2]] // right
    genSide(270,[-width/2+wW,0],tHeight,4,wW,0,0)
    ));
    linear_extrude(1.1*wW,center=true)
    polygon(points = genSide(180,[0,tHeight/2-iBHeight],width,2,wW,wW,wW));
    translate([0,iBHeight/2-displayBorder]) Klappe(false,1.1*wW);
  }
}
/* module for one side plate */
module sidePlate() {
  difference () {  
    linear_extrude(wW,center=true)
    polygon(points = concat(
    //[[tHeight/2,-tDepth/2],[-tHeight/2,-tDepth/2]], rear (downard)
    genSide(180,[0,-tDepth/2],tHeight,4,-wW,wW,0),
    //[[-tHeight/2,-tDepth/2],[-tHeight/2,tDepth/2]], bottom (forward)
    genSide(270,[-tHeight/2,0],tDepth,3,-wW,0,0),
    //[[-tHeight/2,tDepth/2],[-tHeight/2+height,tDepth/2]], front (upward)
    genSide(0,[-tHeight/2+height/2,tDepth/2],height,2,-wW,0,0),
    // [[tHeight/2,-tDepth/2+depth],[-tHeight/2+height,tDepth/2]], display (backward)
    genSide(30,[-tHeight/2+height+sideHeight/2,tDepth/2-sideDepth/2],
        FrontHeight,2,-wW,0,0),
    //[[tHeight/2,-tDepth/2+depth],[tHeight/2,-tDepth/2]]  //top (backward)
    genSide(90,[tHeight/2,-tDepth/2+depth/2],depth,2,-wW,0,0)
    ));
    translate([-iBHeight-wW-1,0]) //not yet sure why plus 1
    linear_extrude(1.1*wW,center=true)
      //take side of innerBottomPlate and omit end points
    polygon(points = genSide(90,[width/2-wW,-tDepth/2+iBDepth/2],iBDepth,1,wW,wW,wW,false,false));
    translate([-iBHeight/2-wW+1,-depth-iBDepth/2+wW+1.5,0])
    linear_extrude(1.1*wW,center=true)
        //take side of innerFrontPlate and cut holes
    polygon(points = genSide(0,[width/2-wW,iBHeight/2-wW/2],iBHeight-wW,2,wW,wW,wW,false,false));
  };
}
/* Module for the front Plate */
module frontPlate(textStr,fontStr,size) {
//    difference() {
    linear_extrude(wW,center=true)
    polygon(points = concat( // shorten all first and last lines
//  [[-width/2, tDepth/2],  [width/2, height/2]], //Topr:
    genSide(0,[0,height/2],width,0,wW,wW,wW),
//    [[width/2,  height/2],  [width/2,-height/2]], // left (seen from front)
    genSide(90,[width/2-wW,0],height,2,wW,0,0),
//    [[width/2, -height/2], [-width/2,-height/2]], // bottom
    genSide(180,[0,-height/2],width,5,-wW,0,0),
//    [[-width/2,-height/2], [-width/2, height/2]] // right
    genSide(270,[-width/2+wW,0],height,2,wW,0,0)
    ));
    rotate([0,180,0]) translate([0,-height/4,wW/2])
    linear_extrude(wW,center=true)
    text(textStr,fontStr,size=size,halign="center",valing="center");
//    }
}
/* Module for the bottom plate */
module bottomPlate() {
linear_extrude(wW,center=true)
polygon(points = concat( // shorten all first and last lines
//  [[-width/2, tDepth/2],  [width/2, tDepth/2]], //Front:
    genSide(0,[0,tDepth/2-wW],width,5,wW,wW,wW),
//    [[width/2,  tDepth/2],  [width/2,-tDepth/2]], // left (seen from front)
    genSide(90,[width/2-wW,0],tDepth,3,wW,wW,wW),
//    [[width/2, -tDepth/2], [-width/2,-tDepth/2]], // rear
    genSide(180,[0,-tDepth/2+wW],width,2,wW,wW,wW),
//    [[-width/2,-tDepth/2], [-width/2, tDepth/2]] // right
    genSide(270,[-width/2+wW,0],tDepth,3,wW,wW,wW)
    ));
}
/*
 * Helper to generate a side
 * a – direction of the line
 * v - shift (starting point)
 * 
 */
function genSide(a,v,sL,fC,h=wW,sLe=0,sRi=0,eP=true,sP=true) =
(sP==true) ? generateSide([rotM(a)*[-sL/2+sRi,0]+v],sL,0,a,v,sLe,sRi,h,fC,eP)
: generateSide([],sL,0,a,v,sLe,sRi,h,fC,eP);
//Recursively generate fC toothes
function generateSide(pL,sL,i,a,v,sLe,sRi,h,fC,eP) = (i==fC) ? ((eP==true) ? concat(pL,[rotM(a)*[(sL)/2-sRi,0]+v]) : pL)
    : generateSide(concat(pL,[
        rotM(a)*[-sL/2+(2*i+1)*sL/(2*fC+1),0]+v, rotM(a)*[-sL/2+(2*i+1)*sL/(2*fC+1),h]+v,
        rotM(a)*[-sL/2+(2*i+2)*sL/(2*fC+1),h]+v, rotM(a)*[-sL/2+(2*i+2)*sL/(2*fC+1),0]+v]),
        sL,i+1,a,v,sLe,sRi,h,fC,eP);
function rotM(a) = [[cos(a),sin(a)],[-sin(a),cos(a)]];