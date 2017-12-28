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
width = displayWidth+2*displayBorder-2*wW;
include <genRectSide.scad>;
polygon(points=concat(
genLine([width/2,iBHeight-wW],[-width/2+wW,iBHeight-wW],fH=wW,fC=2,cO=1,fTR=0),
[[-width/2,iBHeight-wW]])
);
