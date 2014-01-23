use <Finger TEST2.scad>
use <IndexMiddleTest.scad>
use <PinkyTest.scad>
use <ThumbTest.scad>
use <Palm.scad>


module Hand()
{
union()
{
Palm();
translate([PalmLength(),0,0])
{
	Pinky();
}
translate([PalmLength(),FingerBaseWidth()+2,0])
{
	IndexRing();
}
translate([PalmLength(),FingerBaseWidth()*2+4,0])
{
	Finger();
}
translate([PalmLength(),FingerBaseWidth()*3+6,0])
{
	IndexRing();
}
}
}
Hand();

translate([15, PalmWidth()*2/3-HingeDepth(),0])
rotate([0,0,50])
{
	Thumb();
}