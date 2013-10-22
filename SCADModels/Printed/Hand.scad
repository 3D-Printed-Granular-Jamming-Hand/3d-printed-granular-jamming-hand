use <Finger.scad>
use <Palm.scad>

module Hand()
{
union()
{
Palm();
translate([PalmLength(),0,0])
{
	Finger();
}
translate([PalmLength(),FingerBaseWidth()+1,0])
{
	Finger();
}
translate([PalmLength(),FingerBaseWidth()*2+2,0])
{
	Finger();
}
translate([PalmLength(),FingerBaseWidth()*3+3,0])
{
	Finger();
}
}
}
Hand();

translate([PalmLength()/3, PalmWidth()-HingeDepth(),0])
rotate([0,0,50])
{
	Finger();
}