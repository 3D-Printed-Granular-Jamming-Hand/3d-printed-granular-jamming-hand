use <../Tolerances/PlasticWidth.scad>
use <Finger_Spring_Semester.scad>

function PalmLength()=88.19;
function PalmWidth()=79+8;
function PalmHeight()=19.75;

function FingerSpace()=PalmWidth()/4+FingerWidth()/2;


//make wrist connection




module PalmCableGuide(Length=PalmLength()/1.6-HingeDepth()*3)
{
	rotate([0,90,0])
	{
		difference()
		{
			union()
			{
				cylinder(r=FingerWidth()/5, h=Length, $fn=50);
				translate([-FingerHeight()/1.5+FingerWidth()/6,-FingerWidth()/5,0])
			{
				cube([FingerHeight()/1.5-FingerWidth()/6, FingerWidth()/2.5, Length]);
			}
			}
			union()
			{
				translate([0,0,-1])
				{
					cylinder(r=FingerWidth()/8, h=Length+2, $fn=50);
				}
			translate([-FingerHeight()/1.5+FingerWidth()/6-1,-FingerWidth()/8,-1])
			{
				cube([FingerHeight()/1.5-FingerWidth()/6+1, FingerWidth()/4, Length+2]);
			}
			}
		}
	}
}

//PalmCableGuide();

//translate([0,-10,-5])
//CableGuide();

//obviously the wire guides need to be revamped


module Palm()
{
	union()
	{
		difference()
		{

//basic hollow palm shape
			translate([0,0,-PalmHeight()+FingerHeight()])
			{
				cube([PalmLength()-HingeDepth(), PalmWidth(), PalmHeight()]);
			}
			translate([-1, PlasticWidth()*2, -PalmHeight()+FingerHeight()-1])
			{
				cube([PalmLength()-HingeDepth()-PlasticWidth()*2+1,PalmWidth()-PlasticWidth()*4, PalmHeight()-PlasticWidth()*2+1]);
			}

//these are the holes for the cables, they ought to be made into a function, they're not lined up with fingers though, fix this
			translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerWidth()/2-FingerWidth()/8,PlasticWidth()])
			{
				cube([PlasticWidth()*2+2, FingerWidth()/4, FingerHeight()/2]);
			}
			translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerSpace()-FingerWidth()/8,PlasticWidth()])
			{
				cube([PlasticWidth()*2+2, FingerWidth()/4, FingerHeight()/2]);
			}
			translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerSpace()*2-FingerWidth()/8,PlasticWidth()]) //you broke all of these
			{
				cube([PlasticWidth()*2+2, FingerWidth()/4, FingerHeight()/2]);
			}
			translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerSpace()*2-FingerWidth()/8,PlasticWidth()])
			{
				cube([PlasticWidth()*2+2, FingerWidth()/4, FingerHeight()/2]);
			}
				translate([15,PalmWidth()/2,-PalmHeight()+FingerHeight()-1])
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

//could also make this into a function
//also fix lineup
			translate([PalmLength(),0,0])
			{
				NegativeHinge();
			}
			translate([PalmLength(),FingerWidth()+2.7,0])
			{
				NegativeHinge();
			}
			translate([PalmLength(),FingerWidth()*2+5.2,0])
			{
				NegativeHinge();
			}
			translate([PalmLength(),FingerWidth()*3+7.9,0])
//these numbers are mad ugly
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
			translate([0,22,-PlasticWidth()*2+FingerHeight()])
			{
				cube([20,20, PlasticWidth()*2]);
			}
			translate([0,25,-PlasticWidth()*2+FingerHeight()])
			{
				cube([4,20, PlasticWidth()*2]);
			}
		}
		translate([-PalmLength(),0,-1])
		{
			cube([PalmLength(),PalmWidth()-PlasticWidth()*4, PalmHeight()+3]);
		}		
}

//these numbers are some serious jankness

translate([55.1-54,FingerWidth()/2,5])
	{
	PalmCableGuide(76);
	}
translate([55.1,FingerWidth()*1.5+1,5])
	{
	PalmCableGuide();
	}
translate([55.1,FingerWidth()*2.5+2,5])
	{
	PalmCableGuide();
	}
translate([55.1,FingerWidth()*3.5+3,5])
	{
	PalmCableGuide();
	}



	}
}

Palm();



