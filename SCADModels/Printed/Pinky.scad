use <../Purchased/RubberBand.scad>
use <CommonModules.scad>

//finger size values are based on the research in the "real hands" folder

function FingerTipLength(tolerance=0)=17.4+tolerance;
function FingerMidLength(tolerance=0)=26.33+tolerance;
function FingerBaseLength()=24.63;
		

module FingerTip()
{
	union()
	{
		difference()
		{		
			union()
			{
				translate([HingeDepth()+2+FingerTipLength()/2.5+1, 0, 0])
				{
					cube([FingerTipLength()-HingeDepth()-4, FingerWidth(), FingerHeight()]);
				}
				Hinge();
			}			
			translate([FingerTipLength()+HingeDepth()/2-PlasticWidth()*1.5-1,FingerWidth()*3/8, FingerHeight()-FingerHeight()/3-PlasticWidth()])
			{
				cube([PlasticWidth()*1.5+2, FingerWidth()/4, FingerHeight()/3]);
			}
		}
		translate([FingerTipLength()+HingeDepth()/2-PlasticWidth()/1.5, 0, FingerHeight()*.835-PlasticWidth()])
		{
			rotate([-90,0,0])
			{
				cylinder(r=GenericPinDiameter()/2, h=FingerWidth(), $fn=50);				
			} 
		}
	}
}

//FingerTip();



//to check that the effective length is correct
//translate([HingeDepth()/2, 0, 0])
//{
//	#cube([FingerTipLength(), 10, 10]);
//}

module FingerMid()
{
	union()
	{
		difference()
		{
			Hinge();
			translate([FingerMidLength()/2+JointClearance()+1,0,FingerHeight()-BandKeepAwayHeight()+1])
			{
				cube([FingerMidLength()/3, FingerWidth(), FingerHeight()/2+1]);
			}
		}
		translate([FingerMidLength(),0,0])
		{
			difference()
			{
				NegativeHinge();
				difference()
				{
					translate([-HingeDepth()-4,-1,-1])
					{
						cube([FingerHeight()/2+1, FingerWidth()+2, FingerHeight()/2+1]);
					}
					union()
					{
						translate([-HingeDepth()/2+JointClearance()+1, 0, FingerHeight()/2])
						{
							rotate([-90,0,0])
							{
								cylinder(r=FingerHeight()/2, h=FingerWidth(), $fn=50);
							}
						}
						translate([-FingerMidLength()/2,FingerWidth()/4,0])
						{
							cube([FingerWidth(),FingerWidth()/2,FingerHeight()]);
						}
					}					
				}
				translate([-FingerMidLength()-HingeDepth()/2+1,-1,0])
				{
					cube([FingerHeight(),FingerHeight()+2,FingerHeight()+1]);	
				}			
			}
		}		
	}
}
  

//FingerMid();

//to check that the effective length is correct
//translate([HingeDepth()/2, 0, 0])
//{
//	#cube([FingerMidLength(), 10, 10]);
//}


module FingerBase()
{
	difference()
	{
		union()
		{
			difference()
			{
				Hinge();
				translate([HingeDepth()+3,0,FingerHeight()-BandKeepAwayHeight()])
				{
					cube([HingeDepth(),FingerWidth(),BandKeepAwayHeight()*2]);
				}
			}
			translate([FingerBaseLength(),0,0])
			{
				NegativeHinge();
			}
		}
		translate([HingeDepth()*2-PlasticWidth()/2, 0, 0])
		{
			difference()
				{
					translate([-FingerBaseLength()/2,-1,-1])
					{
						cube([FingerBaseLength()/2,FingerWidth()+2,FingerHeight()/2+1]);
					}
					translate([-FingerBaseLength()/2,FingerWidth()/4,-1])
					{
						cube([FingerBaseLength()/2,FingerWidth()/2,FingerHeight()/2+1]);
					}
					translate([1.2,-1,FingerHeight()/2])
					{
						rotate([-90,0,0])
						{
							cylinder(r=FingerHeight()/2,h=FingerWidth()+2, $fn=50);
						}
					}
				}	
			
		}
	}
}



//FingerBase();

//to check that the effective length is correct
//translate([HingeDepth()/2, 0, 0])
//{
//	#cube([FingerBaseLength(), 10, 10]);
//}


module Pinky()
{
	union()
	{
		translate([FingerMidLength()+FingerBaseLength(),0,0])
		{
			FingerTip();
		}
		translate([FingerBaseLength(),0,0])
		{
			FingerMid();
		}
	FingerBase();
	}
}

module FingerBent()
{
	union()
	{
		translate([FingerMidLength()+FingerBaseLength()-4,0,13])
		{
			rotate([0,90,0])
			color("blue")
			FingerTip();
		}
		translate([FingerBaseLength(),0,0])
		{
			FingerMid();
		}
	translate([58,0,-40])
	rotate([0,-90,0])
	color("green")
	FingerBase();
	}
}

//FingerBent();


Pinky();

//translate([0,0,FingerBaseHeight()])
//rotate([0,180,0])
//Finger();
