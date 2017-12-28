/*
 * Vizuals
 */
flat = false;
spacing = 10;

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


//Dont change these values
FrontHeight = displayHeight+2*displayBorder;
sideHeight = FrontHeight*sin(60);
sideDepth = FrontHeight*cos(60);
width = displayWidth+2*displayBorder;
tDepth = depth+sideDepth;
totalHeight = sideHeight+height;


bottomPlate();
echo(genSide(a=0,v=[0,tDepth/2],width,1,wW,0,0));
echo(generateSide([rotM(0)*[-width/2,0]+[0,0]],width,0,0,[0,0],0,0,wW,2,true));
/* Module for the bottom Plate */
module bottomPlate() {
polygon(points = concat(
//    [-width/2, tDepth/2],  [width/2, tDepth/2], //Front:
    generateSide([rotM(0)*[-width/2,0]+[0,tDepth/2-wW]],width,0,0,[0,tDepth/2-wW],0,0,wW,2,true),
//    generateSide(a=0,v=[-width/2,tDepth/2],sLe=0,sRi=0,h=wW,fC=4),
    [[width/2,  tDepth/2],  [width/2,-tDepth/2],
    [width/2, -tDepth/2], [-width/2,-tDepth/2],
    [-width/2,-tDepth/2], [-width/2, tDepth/2]
    ]
    ));
}
/*
 * Helper to generate a side
 * a – direction of the line
 * v - shift (starting point)
 * 
 */
function genSide(a,v,sL,fC,h=wW,sLe=0,sRi=0,eP=true) = generateSide([rotM(a)*[-(sL-sLe)/2,0]+v],
    sL,i,a,v,sLe,sRi,h,fC,eP);   
//Recursively generate fC toothes
function generateSide(pL,sL,i,a,v,sLe,sRi,h,fC,eP) = (i==fC) ? ((eP==true) ? concat(pL,[rotM(a)*[(sL-sRi)/2,0]+v]): [])
    : generateSide(concat(pL,[
        rotM(a)*[-sL/2+(2*i+1)*sL/(2*fC+1),0]+v, rotM(a)*[-sL/2+(2*i+1)*sL/(2*fC+1),h]+v,
        rotM(a)*[-sL/2+(2*i+2)*sL/(2*fC+1),h]+v, rotM(a)*[-sL/2+(2*i+2)*sL/(2*fC+1),0]+v]),
        sL,i+1,a,v,sLe,sRi,h,fC,eP);
function rotM(a) = [[cos(a),sin(a)],[-sin(a),cos(a)]];