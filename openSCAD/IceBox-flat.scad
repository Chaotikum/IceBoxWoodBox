include <genRectSide.scad>;
/*
 *    Maße
 */
displayWidth = 170;
displayHeight = 110;
displayBorder = 20;
depth = 70;  // Depth behind end of upper end of display plate
height = 70; // Height below display plate
iBHeight = 100;
iBDepth = 40;
slotWidth = 40;
slotDepth = 7.5;
wW = 4;
cRadius = 20;

//Visually
extend = 2*wW; //0=closed, otherwise whis is the distance between plates
//Dont change these values
side = displayHeight+2*displayBorder;
sideHeight = side*sin(60);
sideWidth = side*cos(60);
width = displayWidth+2*displayBorder-2*wW;
totalDepth = depth+sideWidth+wW/2;
totalHeight = sideHeight+height;
//Bottom plate
color([.7,.7,.7])
linear_extrude(wW)
polygon(points=concat(
    genLine([-width/2,0],[-width/2,totalDepth],fH=wW,fC=2,fTR=0),
    genLine([-width/2,totalDepth],[width/2,totalDepth],fH=wW,fC=2,cO=1),
    genLine([width/2,totalDepth],[width/2,0],fH=wW,fC=2),
    genLine([width/2+wW,0],[-width/2,0],fH=wW,fC=2,cO=1,fTR=0)
    ));
// Rear
color([1,.7,.3]) translate([0,-totalHeight-extend])
linear_extrude(wW)
    difference() {
        polygon(points=concat(
        genLine([-width/2,0],[-width/2,totalHeight],fH=wW,fC=2, cO=1,fTR=0),
        genLine([-width/2,totalHeight],[width/2+wW,totalHeight],fH=wW,fC=2,cO=1),
        genLine([width/2+wW,totalHeight],[width/2+wW,0],fH=wW,fC=2, cO=1, fTR=0),
        genLine([width/2+wW,0],[-width/2,0],fH=wW,fC=2,cO=1,fTR=0)
        ));
        //holes for inner plate
        translate([0,iBHeight]) rotate(90,[1,0,0])
            polygon(points=concat(
            [[width/2,3*wW]],
            genLine([width/2,wW],[-width/2,wW],fH=1.2*wW,fC=2,cO=1,fTR=1),
            [[-width/2,3*wW]]
          ));
        //Hole for Klappe
        translate([0,iBHeight-wW,0]) rotate(180,[0,0,1])
        hull() {
            polygon(points=[[-width/2+displayBorder,0],[width/2-displayBorder,0],
              [width/2-displayBorder, iBHeight/2],[-width/2+displayBorder,iBHeight/2]]);
            translate([-width/2+displayBorder+cRadius, iBHeight-displayBorder-cRadius, 0])
            circle(r=cRadius,$fn=360);
            translate([width/2-displayBorder-cRadius, iBHeight-displayBorder-cRadius, 0])
    circle(r=cRadius,$fn=360);
};
}

//Top
color([.4,.7,.7])
translate([0,-totalHeight-depth-2*extend])
linear_extrude(wW)
difference() {
polygon(points=concat( //2*wW on each because they all turn fingers inwards
    genLine([-width/2,0],[-width/2,depth],fH=wW,fC=2,fTR=0),
    genLine([-width/2,depth],[width/2+wW,depth],fH=wW,fC=2,cO=1),
    genLine([width/2,depth],[width/2,0],fH=wW,fC=2),
    genLine([width/2+wW,0],[-width/2,0],fH=wW,fC=2,cO=1)
    ));
translate([wW/2,0,0])
    polygon(points=[[-slotWidth/2,1/3*depth-slotDepth/2],
             [-slotWidth/2,1/3*depth+slotDepth/2],
             [slotWidth/2,1/3*depth+slotDepth/2],
             [slotWidth/2,1/3*depth-slotDepth/2]]);
translate([0,iBDepth]) rotate(90,[1,0,0])
    polygon(points=concat(
     [[width/2,0]],
     genLine([width/2,wW],[-width/2+wW,iBHeight-wW],fH=1*wW,fC=2,cO=1,fTR=0)
     [[-width/2,0]]));
}

# translate([0,iBDepth]) rotate(90,[1,0,0])
    polygon(points=concat(
     [[width/2,0]],
     genLine([width/2,wW],[-width/2+wW,iBHeight-wW],fH=1*wW,fC=2,cO=1,fTR=0)
     [[-width/2,0]]));

//Front
color([.3,.7,.3])
translate([0,totalDepth+extend,0])
linear_extrude(wW)
polygon(points=concat( //2*wW on each because they all turn fingers inwards
    genLine([-width/2+wW,0],[-width/2+wW,height],fH=wW,fC=2,fTR=1), //right
    genLine([-width/2,height],[width/2,height],fH=0,fC=2,cO=1), //top
    genLine([width/2+wW,height],[width/2+wW,0],fH=wW,fC=2,fTR=0), //left
    genLine([width/2,0],[-width/2,0],fH=wW,fC=2,cO=1,fTR=0)
    ));
//Display
sideT = side + wW/tan(60)-2*wW*cos(60)/sin(60);
color([.9,.9,.9])
translate([0,depth+totalDepth+sideT/2+2*extend,wW])
rotate(180,[1,0,0])
linear_extrude(wW)
difference() {
polygon(points=concat(
    genLine([-width/2,-sideT/2],[-width/2,sideT/2],fH=wW,fC=2,fTR=0), //top
    genLine([-width/2,sideT/2],[width/2,sideT/2],fH=0,fC=2,cO=1),
    genLine([width/2,sideT/2],[width/2,-sideT/2-wW*cos(60)/2],fH=wW,fC=2),
    genLine([width/2+wW,-sideT/2-wW*cos(60)/2],[-width/2,-sideT/2-wW*cos(60)/2],fH=wW,fC=2,cO=1,fTR=0)
    ));
translate([wW/2,0])
polygon(points=[[-width/2+displayBorder,-side/2+displayBorder],
    [width/2-displayBorder,-side/2+displayBorder],
    [width/2-displayBorder,side/2-displayBorder],
    [-width/2+displayBorder,side/2-displayBorder]]); 
}
//Side plate
translate([width/2+extend,wW]) rotate(0,[0,1,0]) sidePlate();
translate([-width/2+wW-extend,wW,wW]) rotate(180,[0,1,0]) sidePlate();

module sidePlate() {
linear_extrude(wW)
difference() {
  polygon(points=concat(
    genLine([0,0],[totalHeight,0],fH=wW,fC=2, cO=1,fTR=0)
    +[[0,0],[wW,0],[wW,0],[wW,0],[wW,0],[wW,0],[wW,0],[wW,0],[wW,0],[wW,0]]
    , //Rear + trckshift
    genLine([totalHeight,0],[totalHeight,depth],fH=wW,fC=2,fTR=0), //top
    genLine([totalHeight,depth],[height,totalDepth-wW],fH=wW,fC=2,fTR=0)
    +[[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]], //Display
    [[height,totalDepth]],
    genLine([height,totalDepth-wW],[0,totalDepth-wW],fH=wW,fC=2,fTR=0)
    ,
    //front + trickshift first
    genLine([0,totalDepth],[0,0],fH=wW,fC=2,fTR=1)
    -[[0,0],[0,wW],[0,wW],[0,wW],[0,wW],[0,wW],[0,wW],[0,0]]
    //bottom line + trickshift
    ));
    translate([totalHeight-iBHeight+wW,iBDepth,0])
    polygon(points=[[29,0],[29,-wW],[59,-wW],[59,0]]);
    translate([totalHeight-iBHeight+2*wW,0,0])
    polygon(points=
    [[0,9],[-wW,9],[-wW,29],[0,29]]);
}
};

//Inner bottom
color([.5,.5,.5])
translate([-width-wW-extend,-iBDepth-extend,0])
linear_extrude(wW)
polygon(points=concat(//side
    [[-width/2+wW,0],[-width/2+wW,9],[-width/2,9],[-width/2,29],[-width/2+wW,29],
        [-width/2+wW,iBDepth-wW]],
        //front
    [[-width/2+wW,iBDepth-wW],
     [-width/2+38.5,iBDepth-wW],[-width/2+38.5,iBDepth],
     [-width/2+58.5,iBDepth],[-width/2+58.5,iBDepth-wW],
     [width/2-58.5,iBDepth-wW],[width/2-58.5,iBDepth],
     [width/2-38.5,iBDepth],[width/2-38.5,iBDepth-wW],
     [width/2-wW,iBDepth-wW]
    ],
    [[width/2,iBDepth-wW],[width/2,29],[width/2+wW,29],[width/2+wW,9],
     [width/2,9],[width/2,0]],
    genLine([width/2,0],[-width/2,0],fH=wW,fC=2,cO=1,fTR=1)
    ));

//Inner front
color([.7,.4,0])
translate([width+wW+extend,-iBHeight-extend,0]) rotate(0,[1,0,0])
linear_extrude(wW)
    polygon(points=concat(//side
     [[-width/2+wW,iBHeight-wW],[-width/2+wW,59],[-width/2,59],[-width/2,29],
     [-width/2+wW,29],[-width/2+wW,0]],
        //front
    [[-width/2,0],
     [-width/2+38.5,0],[-width/2+38.5,wW],
     [-width/2+58.5,wW],[-width/2+58.5,0],
     [width/2-58.5,0],[width/2-58.5,wW],
     [width/2-38.5,wW],[width/2-38.5,0],
     [width/2,0]
    ],
        [[width/2,iBHeight-wW],[width/2,59],[width/2+wW,59],[width/2+wW,29],
     [width/2,29],[width/2,-wW]],
     genLine([width/2,iBHeight-wW],[-width/2+wW,iBHeight-wW],fH=wW,fC=2,cO=1,fTR=0)
    ));
//Klappe
translate([-width+displayBorder-extend,-totalHeight+height+displayBorder,wW]) rotate(180,[1,0,0])
linear_extrude(wW)
difference() {
hull() {
 polygon(points=[[-width/2+displayBorder,0],[width/2-displayBorder,0],
    [width/2-displayBorder, iBHeight/2],[-width/2+displayBorder,iBHeight/2]]);
translate([-width/2+displayBorder+cRadius, iBHeight-displayBorder-cRadius, 0])
    circle(r=cRadius,$fn=360);
translate([width/2-displayBorder-cRadius, iBHeight-displayBorder-cRadius, 0])
    circle(r=cRadius,$fn=360);
};
translate([0, iBHeight-displayBorder-1*cRadius, 0])
    circle(r=2*cRadius/3,$fn=360);
}