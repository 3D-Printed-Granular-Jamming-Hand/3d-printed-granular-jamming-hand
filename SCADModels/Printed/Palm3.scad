use <Finger_Spring_Semester.scad>
use <../Purchased/RubberBand.scad>
use <../Purchased/High_Low_Screw_As_Bolt.scad>


function PalmLength()=88.19;
function PalmWidth()=79+8;
function PalmHeight()=19.75;

function PalmHoleWidth()=FingerWidth()/8; //the width of the holes allowing the cables into the palm
function FingerSpace()=(PalmWidth()-FingerWidth()*4)/3+FingerWidth(); //spacing between fingers
function ThumbAngle()= 50; //angle of thumb attachment




//this makes the basic shape for the cable guides (the structures along the palm of the hand)
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
					cylinder(r=PalmHoleWidth(), h=Length, $fn=50);
					translate([-FingerHeight()/1.5+FingerWidth()/6,-PalmHoleWidth(),0])
					{
						cube([FingerHeight()/1.5-FingerWidth()/6, PalmHoleWidth()*2, Length]);
					}
				}
				union()
				{
					translate([0,0,-1])
					{
						cylinder(r=PalmHoleWidth()/2, h=Length+2, $fn=50);
					}
					translate([-FingerHeight()/1.5+FingerWidth()/6-1,-PalmHoleWidth()/2,-1])
					{
						cube([FingerHeight()/1.5-FingerWidth()/6+1, PalmHoleWidth(), Length+2]);
					}
				}
			}
		}
	}
}

//BasePalmCableGuide();

//this basically just places the base cable guide at an appropriate height for the hand
module PalmCableGuide(Length=10)
{
	translate([PalmLength()-HingeDepth()-PlasticWidth()*2-Length+4.9,FingerWidth()/2,0])
	{
		BasePalmCableGuide(Length);
	}
}

//PalmCableGuide();

//These are the angled guides, they are at the same angle as the thumb attachment
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
		}
	}
}

//AngledPalmCableGuide();


//This is the finished cable guide, it takes in 3 lengths, and using these lengths, generates a cable guide (so this way you can determine how far over you need your cable guide to go, how long it should be, etc
module BentPalmCableGuide(Length1=60, Length2=60, Length3=40)
{
translate([PalmLength()-HingeDepth()+6.9,FingerWidth()/2+4,0])
	{
	translate([-Length1-(Length2 * cos(ThumbAngle())),-(Length2 * sin(ThumbAngle())),0])
	{
		union()
		{
			translate([Length2*cos(ThumbAngle())-FingerWidth()*.35,Length2*sin(ThumbAngle())-FingerWidth()*.2,0])
			{
				union()	
				{
					BasePalmCableGuide(Length1);
					translate([-PalmHoleWidth()*2.5,-PalmHoleWidth()*2.5,0])
					{
						AngledPalmCableGuide(Length2);								
						
					}
				}
			}
			translate([-Length3-PalmHoleWidth()*5,-PalmHoleWidth()*2.5,0])
			{
				BasePalmCableGuide(Length3);
			}			
		}
	}
}
}
//BentPalmCableGuide();


//these are the holes in the edge of the palm allowing the cables to go from the fingers to the palm cable guides
module PalmHole()
{
	translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerWidth()/2-PalmHoleWidth()/2,PlasticWidth()+1])
	{
		cube([PlasticWidth()*2+2, PalmHoleWidth(), FingerHeight()/2-1]);
	}
}


//This just spaces the thumb out from the palm so they won't meld together
module ThumbGuard()
	{
	translate([HingeDepth(),0,0])
	{
		difference()
		{
			union()
			{
				difference()
				{
					translate([-HingeDepth(),0,0])
					{
						cube([HingeDepth()*2-2.5, PlasticWidth()*1.5, FingerHeight()]);
					}			
					difference()
					{
						translate([-1,-1,-1])
						{
							cube([HingeDepth()+2, FingerWidth()+2, FingerHeight()/2+1]);
						}
						translate([0, 0, FingerHeight()/2])
						{
							rotate([-90,0,0])
							{
								cylinder(r=FingerHeight()/2, h=FingerWidth(), $fn=50);
							}
						}
					}
				}		
			}
			translate([FingerHeight()/4, 5, FingerHeight()/2])
			{
				rotate([90,0,0])
				{
				cylinder(r=2, h=10, $fn=30);
				}
			}
		}
	}
}

//ThumbGuard();


//These are the bolts that will attach the hand to the forearm
module Bolt()
{
	translate([0,0,PalmHeight()])
	{
		#HiLoBolt(.4, PlasticWidth()*1.6+BandKeepAwayHeight()+1);
	}
}



//Then this is the palm itself
module Palm()
{
	union()
	{
		difference()
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
				translate([-1, PlasticWidth(), -PalmHeight()+FingerHeight()-1])
				{
					cube([PalmLength()-HingeDepth()-PlasticWidth()+1,PalmWidth()-PlasticWidth()*2, PalmHeight()-PlasticWidth()+1]);
				}

//these are the holes for the cables, they ought to be made into a function
//also not sure what this one is doing up here--look into this later
				PalmHole();
			}
			union()
			{
				translate([8.8+PlasticWidth()*2,PalmWidth()/2-9.5,-PalmHeight()+FingerHeight()])
				{
					rotate([0,0,ThumbAngle()])
					{
						cube([PalmLength()*.75,PalmWidth()-PlasticWidth()*4, PalmHeight()]);					
					}
				}	
			}
		}
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

		translate([8+PlasticWidth(),PalmWidth()/2-7.5,-PalmHeight()+FingerHeight()-1])
		{
			rotate([0,0,ThumbAngle()])
			{
				cube([PalmLength(),PalmWidth()-PlasticWidth()*4, PalmHeight()+2]);					
			}
		}
		translate([0,PalmWidth(),-3])
		{
			cube([PalmLength(),PalmWidth()-PlasticWidth()*4, PalmHeight()+2]);		
				
		}
	}
//These are the finger joints
//could also make this into a function
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
					translate([3,0,0])
					{
						NegativeHinge();
					}
				}
			}
			translate([0,0,PalmHeight()-PlasticWidth()*2-BandKeepAwayHeight()-1.7])
			{
				cube([15,PalmWidth()/2-1, PlasticWidth()*1.6+BandKeepAwayHeight()]);
			}
			translate([0,0,PalmHeight()-PlasticWidth()*2-BandKeepAwayHeight()-1.7])
			{
				cube([3.8,PalmWidth()/2+2.2, PlasticWidth()*1.6+BandKeepAwayHeight()]);
			}
		}
		translate([-PalmLength(),0,-1])
		{
			cube([PalmLength(),PalmWidth()-PlasticWidth()*4, PalmHeight()+3]);
		}	
	}

//these numbers are a little hacky	
	PalmCableGuide(PalmLength()-HingeDepth());
	translate([0,FingerSpace(),0])
	{
		BentPalmCableGuide(10,FingerSpace()*.9,48.9);
	}
	translate([0,FingerSpace()*2,0])
	{
		BentPalmCableGuide(10,FingerSpace()*1.95,33.8);
	}
	translate([0,FingerSpace()*3,0])
	{
		BentPalmCableGuide(10,FingerSpace()*3,18.6);
	}
	translate([15,-32,0])
	{
		rotate([0,0,90])
		{
			PalmCableGuide(10);
		}
	}
	translate([1,28,0])
	{
		AngledPalmCableGuide(4.5);		
	}
		difference()
		{
			translate([PlasticWidth()+9.6,PalmWidth()/2-8,0])
			{
				rotate([0,0,ThumbAngle()])
				{
					ThumbGuard();
				}
			}			
		}
		translate([-PalmLength()/4.5,0,-PalmHeight()+FingerHeight()])
		{
			cube([PalmLength()/4.5,PlasticWidth(), PalmHeight()]);
		}
		difference()
		{
			translate([-PalmLength()/4.5,0,PalmHeight()-PlasticWidth()*2-BandKeepAwayHeight()-1.7])
			{
				cube([PalmLength()/4.5,PalmWidth()/2+13, PlasticWidth()*1.6+BandKeepAwayHeight()]);
			}
		translate([-PalmWidth()/16,PalmWidth()/1.8,0])
		{
			Bolt();
		}
		translate([-PalmWidth()/6,PalmWidth()/1.8,0])
		{
			Bolt();
		}
		translate([-PalmWidth()/16,PlasticWidth()*2.5,0])
		{
			Bolt();
		}
		translate([-PalmWidth()/6,PlasticWidth()*2.5,0])
		{
			Bolt();
		}
		}	///NOOO WHERE IS THE OTHER MISMATCH
	}
}


Palm();



