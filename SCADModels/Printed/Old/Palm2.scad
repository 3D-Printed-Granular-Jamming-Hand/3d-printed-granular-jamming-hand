use <Finger_Spring_Semester.scad>

function PalmLength()=88.19;
function PalmWidth()=79+8;
function PalmHeight()=19.75;

function PalmHoleWidth()=FingerWidth()/4;
function FingerSpace()=(PalmWidth()-FingerWidth()*4)/3+FingerWidth();
function ThumbAngle()= 50;


//make wrist connection



module sweeptest()
{

}









module BasePalmCableGuide(Length=10)
{
	translate([0,0,PlasticWidth()*2])
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
}

module PalmCableGuide(Length=10)
{
	translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerWidth()/2,0])
	{
		BasePalmCableGuide(Length);
	}
}
//#PalmCableGuide();

module AngledPalmCableGuide(Length=50)
{
	translate([-Length*cos(ThumbAngle())-FingerWidth()*.3+FingerWidth()/2,-Length*sin(ThumbAngle())+FingerWidth()/4,0])
	{
	difference()
	{
		rotate([0,0,ThumbAngle()])
		{
			BasePalmCableGuide(Length);
		}
	translate([Length*cos(ThumbAngle())-FingerWidth()*.2,Length*sin(ThumbAngle())-FingerWidth()/4-1,0])
	{
		cube([FingerWidth(),FingerWidth(),FingerWidth()]);
	}
	}
}
}

module BentPalmCableGuide(Length=40, Length2=30, Length3=30)
{
translate([Length3,-FingerWidth()/2.15,0]) //PalmLength()Length3-Length-Length2*cos(ThumbAngle())+10
	{
	union()
{
	translate([Length2*cos(ThumbAngle())-FingerWidth()*.35,Length2*sin(ThumbAngle())-FingerWidth()*.2,0])
	{
	union()
	{
		difference()
		{
			BasePalmCableGuide(Length);
			rotate([0,0,ThumbAngle()])
			{
				translate([-FingerWidth()/4,-FingerWidth()/5.3,4])
				{
					cube([FingerWidth()/4,FingerWidth()/4,FingerWidth()]);
				}
			}
		}
		translate([0,-2.2,0])
		{
			difference()
			{
				AngledPalmCableGuide(Length2);
				translate([-Length*cos(ThumbAngle())-FingerWidth()*.5,-Length*sin(ThumbAngle())+FingerWidth()*.7,FingerWidth()/5])
				{
					cube([FingerWidth(),FingerWidth()/8,FingerWidth()]);
				}
				
			}
		}
	}
}
	difference()
	{
	translate([-Length3,0,0])
	{
	BasePalmCableGuide(Length3);
	}
	
					rotate([0,0,ThumbAngle()])
					{
					cube([FingerWidth()*1.3,FingerWidth(),FingerWidth()]);
				}
				
}

}
}
}


//BentPalmCableGuide();

//translate([0,-10,-5])
//CableGuide();

//obviously the wire guides need to be revamped

module PalmHole()
{
	translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerWidth()/2-PalmHoleWidth()/2,PlasticWidth()])
	{
		cube([PlasticWidth()*2+2, PalmHoleWidth(), FingerHeight()/2]);
	}
}

module Palm()
{
	union()
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

//these are the holes for the cables, they ought to be made into a function
			PalmHole();
			
			translate([0,FingerSpace(),0])
			{
				PalmHole();
			}
			translate([0,FingerSpace()*2,0])
			{
				PalmHole();
			}
			translate([0,FingerSpace()*3,0])
			{
				PalmHole();
			}
				translate([15,PalmWidth()/2,-PalmHeight()+FingerHeight()-1])
				{
					rotate([0,0,ThumbAngle()])
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
				rotate([0,0,ThumbAngle()])
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

//these numbers are a little hacky

translate([-(PalmLength()-HingeDepth())+PlasticWidth()*2+1,0,0])
	{
	PalmCableGuide(PalmLength()-HingeDepth());
	}
translate([-(PalmLength()/2-HingeDepth()*3)+PlasticWidth()*2+6.5,FingerSpace()+4,0])
	{
	BentPalmCableGuide(7.8,25,60);
	}
translate([-(PalmLength()/1.8-HingeDepth()*3)+PlasticWidth()*2+11,FingerSpace()*2-10,0])
	{
	BentPalmCableGuide(10.5,43,46);
	}
translate([0,FingerSpace()*3-25,0])
	{
	BentPalmCableGuide(10,62,34.1);
	}

difference()
{
	translate([0,30,-2.5])
	{
		rotate([0,0,-42])
		{
			cube([PlasticWidth()*2, 75, PalmHeight()]);
		}
	}
	translate([17,10,-10])
	{
		rotate([0,0,50])
		{	
			cube([30,30,30]);
		}
	}	
}
}
	}
}

Palm();



