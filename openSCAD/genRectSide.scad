/* genLine() generate a Line with Fingers
 * startPos    - start position
 * endPos      - endposition
 * startOffSet - start with an offset beofre first finger
 * endOffset   - extend last line with offset
 * fC          - fingerCount - number of fingers
 * fH          - finger height - height of fingers
 * cO          - count Odd - (0) each finger is followed by a line segment of same length (even number of segments); (1) odd number of segments 
 * sWF         - startWithFinger - whether to start with a finger (1) or not (0)
 */
 
function genLine(startPos,endPos, startOffset=0, endOffset=0, fC=3, fH=1, cO=0, sWF=0,fTR=1) = 
    genRectSide(a=-atan2(endPos[1]-startPos[1], endPos[0]-startPos[0]), v=startPos, sStart=-startOffset, sEnd=-endOffset, fTR=fTR, fH=fH,
    fL=( sqrt( pow( (startPos[0]-endPos[0]), 2) + pow( (startPos[1]-endPos[1]), 2) ) -startOffset-endOffset)/(2*fC+cO),
    fC=fC, cO=cO, sWF=sWF);

/*
 * genRectSide() generate Rectangle Side in the xy-plane
 * a      - starting angle
 * v      - shift startpoint from (0,0) to v
 * sStart - shorten the startLine
 * sEnd   - shorten EndLine
 * fTR    - (1) [f]irst corner [t]urns [r]ight (0) first corner turns left
 * fH     - [f]inger[H]eight : height between [f]inger and inner line
 * fC     - [f]inger[C]ount  : number of Fingers
 * fL     - [f]inger[L]ength : length of a Finger
 * cO     - [c]ount [O]dd : each finger is followed by an off-part of same length. This variable
 *                          (0) ends after fC fingers without a finger (1) with a finger                        
 *
 */
function genRectSide(a=0, v=[0,0], sStart=0, sEnd=0, fTR=1, fH=1, fL=2, fC=3, cO=0,sWF=0) =
    genRectSideRec( ((sWF==1) ? [v] : []),a,v,sStart,sEnd,fTR,fH,fL,cO,fC,0);
function genRectSideRec(list,a,v,sStart,sEnd,fTR,fH,fL,cO,upperLimit,cnt) = (cnt==upperLimit)
    ? concat(list, (cO==1) ? [rotM(a)*[(2*cnt)*fL,0]+v, rotM(a)*[(2*cnt+1)*fL-sEnd,0]+v] : [])
    : genRectSideRec(concat(list, // add one finger and its fopllowing off
        [ //2*fTR-1 is 1 for right, -1 for left
        rotM(a)*[2*cnt*fL,0]+v, rotM(a)*[(2*cnt+1)*fL,0]+v,
        rotM(a)*[(2*cnt+1)*fL,(2*fTR-1)*fH]+v, rotM(a)*[(2*cnt+2)*fL - ( ((cO==0)&&(cnt==(upperLimit-1)))?sEnd:0), (2*fTR-1)*fH]+v
        ]),a,v,sStart,sEnd,fTR,fH,fL,cO,upperLimit,cnt+1);
function rotM(a) = [[cos(a),sin(a)],[-sin(a),cos(a)]];