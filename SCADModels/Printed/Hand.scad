use <Mid.scad>
use <IndexRing.scad>
use <Pinky.scad>
use <Thumb.scad>
use <Palm.scad>



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
			translate([5,65,0])
		{
			rotate([0,0,180])
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

