use <../Tolerances/PlasticWidth.scad>
use <Finger.scad>

//didn't bother making a hinge for the thumb because I don't know what it's actually shaped like (right now just using the default finger at a weird angle)

//also didn't bother making a hinge for the wrist because right now I'm just modeling the hand and don't really care about the wrist/forearm assembly


function PalmLength()=88.19;
function PalmWidth()=79+8;
function PalmHeight()=19.75;


module WireGuide()
{
rotate([0,90,0])
	{

	
difference()
{
		cylinder(r=FingerBaseWidth()/8, h=PalmLength()/1.6-HingeDepth()*3, $fn=50);
		translate([0,0,-1])
		{
			cylinder(r=FingerBaseWidth()/16, h=FingerBaseLength()-HingeDepth()*3+2, $fn=50);
		}
}
}
}

module Palm()
{
	union()
	{
		difference()
		{
			cube([PalmLength()-HingeDepth(), PalmWidth(), PalmHeight()]);
			translate([-1, PlasticWidth()*2, -1])
			{
				cube([PalmLength()-HingeDepth()-PlasticWidth()*2+1,PalmWidth()-PlasticWidth()*4, PalmHeight()-PlasticWidth()*2+1]);
			}
			translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerBaseWidth()/2-2.5,PlasticWidth()])
			{
				cube([PlasticWidth()*2+2, FingerTipWidth()/4, FingerTipHeight()/2]);
			}
translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerBaseWidth()*1.5-1.5,PlasticWidth()])
			{
				cube([PlasticWidth()*2+2, FingerTipWidth()/4, FingerTipHeight()/2]);
			}
translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerBaseWidth()*2.5-.5,PlasticWidth()])
			{
				cube([PlasticWidth()*2+2, FingerTipWidth()/4, FingerTipHeight()/2]);
			}
translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerBaseWidth()*3.5,PlasticWidth()])
			{
				cube([PlasticWidth()*2+2, FingerTipWidth()/4, FingerTipHeight()/2]);
			}
				translate([15,PalmWidth()/2,-1])
				{
					rotate([0,0,50])
					{
					translate([-30,0,0])
					{
						cube([PalmLength(),PalmWidth()-PlasticWidth()*4, PalmHeight()+2]);
					}

					}
				}
		}
		translate([PalmLength(),0,0])
		{
			NegativeHinge();
		}
		translate([PalmLength(),FingerBaseWidth()+2,0])
		{
			NegativeHinge();
		}
		translate([PalmLength(),FingerBaseWidth()*2+4,0])
		{
			NegativeHinge();
		}
		translate([PalmLength(),FingerBaseWidth()*3+6,0])
		{
			NegativeHinge();
		}
		difference()
		{
		union()
		{
		translate([15,PalmWidth()/2,0])
		{
			rotate([0,0,50])
			{
				translate([2.5,0,0])
				{
					NegativeHinge();
				}
			}
		}

translate([0,22,PalmHeight()-PlasticWidth()*2])
{
cube([20,20, PlasticWidth()*2]);
}
		}
		translate([-PalmLength(),0,-1])
		{
			cube([PalmLength(),PalmWidth()-PlasticWidth()*4, PalmHeight()+3]);
		}
		
}


translate([HingeDepth()*1.5+PalmWidth()/3,FingerBaseWidth()/2,FingerBaseHeight()-PlasticWidth()*2])
	{
	WireGuide();
	}
translate([HingeDepth()*1.5+PalmWidth()/3,FingerBaseWidth()*1.5+1,FingerBaseHeight()-PlasticWidth()*2])
	{
	WireGuide();
	}
translate([HingeDepth()*1.5+PalmWidth()/3,FingerBaseWidth()*2.5+2,FingerBaseHeight()-PlasticWidth()*2])
	{
	WireGuide();
	}
translate([HingeDepth()*1.5+PalmWidth()/3,FingerBaseWidth()*3.5+3,FingerBaseHeight()-PlasticWidth()*2])
	{
	WireGuide();
	}


	}
}

Palm();


