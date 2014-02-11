use <HiTolerance_Mid_Spring_Semester.scad>
use <HiTolerance_Index_Ring_Spring_Semester.scad>
use <HiTolerance_Pinky_Spring_Semester.scad>
use <HiTolerance_Thumb_Spring_Semester.scad>
use <Palm3.scad>



module Hand()
{
	union()
	{
		Palm();
		translate([PalmLength(),0,0])
		{
			Pinky(); //Pinky
		}
		translate([PalmLength(),FingerWidth()+2+1,0])
		{
			IndexRing(); //Index/Ring
		}
		translate([PalmLength(),FingerWidth()*2+5,0])
		{
			Middle(); //Middle
		}
		translate([PalmLength(),FingerWidth()*3+8,0])
		{
			IndexRing(); //Index/Ring
		}
		translate([17, PalmWidth()*2/3-HingeDepth()-1,0])
		{
			rotate([0,0,50])
			{
				Thumb(); //Thumb
			}
		}
	}
}

//print orientation
translate([0,0,17])
{
	rotate([0,180,0])
	{		
		Hand();
	}
}

