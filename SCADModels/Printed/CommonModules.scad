use <../Purchased/RubberBand.scad>
use <../Purchased/SetScrew.scad>

//finger size values are based on the research in the "real hands" folder

function JointPinBaseDiameter(tolerance=0)=5-tolerance;
function JointPinEndDiameter(tolerance=0)=1-tolerance;
function HingeDepth(tolerance=0)=11+tolerance;

function JointClearance(tolerance=0)=3;
function PinClearance(tolerance=0)=0.3; 

function FingerWidth(tolerance=0)=19.75+tolerance;
function FingerHeight(tolerance=0)=17+tolerance; // made shorter, usually 19.75 though

function PlasticWidth(tolerance=0)=FingerWidth(tolerance)/8;

function GenericPinDiameter(tolerance=0)=2.5+tolerance; //pin at fingertip



//get it to support tolerance properly again (probably broke this a little)
//modify it so all fingers work from the same file
//knock out all the mid stuff

module JointPin(tolerance=0)
{
	cylinder(FingerWidth(-tolerance)/4, JointPinBaseDiameter()/2, JointPinEndDiameter()/2, $fn=50);
}



module JointPinHole(tolerance=0)
{
	cylinder(FingerWidth(-tolerance)/4+PinClearance(tolerance)+1, JointPinBaseDiameter(-tolerance)/2+PinClearance(tolerance), JointPinEndDiameter(tolerance)/2, $fn=50);			
}


module CableGuide(tolerance=0)
{
	difference()
	{
		translate([0,0,1.5])
		{
			cube([PlasticWidth()/1.5, FingerWidth(), FingerHeight()/1.5]);
		}
		translate([-1,FingerWidth()/2,FingerWidth()/8+FingerHeight()/6])
		{
			rotate([0,90,0])
			{
				cylinder(r=FingerWidth()/8, h=PlasticWidth()+2, $fn=50);
			}
		}
	}
}

//CableGuide();



module Hinge(tolerance=0)
{
	difference()
	{
		union()
		{
			difference()
			{
				difference()
				{
					union()
					{
						translate([0, FingerWidth(-tolerance)/4, 0])
						{
							difference()
							{
								cube([HingeDepth(tolerance)*2+1,FingerWidth(tolerance)/2, FingerHeight(tolerance)]);
//set screw addition
								translate([SetScrewLength()-.1,FingerWidth(tolerance)/4,FingerHeight()-SetScrewDiameter()])
								{
									SetScrew();
								}
							}
						}
						translate([HingeDepth()+2.5,0,FingerHeight()/2])
						{
							cube([FingerHeight()/2-1, FingerWidth(), FingerHeight()/2]);
						}		
						translate([HingeDepth(tolerance)*2, 0, FingerHeight()/2])
						{
							rotate([-90,0,0])
							{
								cylinder(r=FingerHeight()/2, h=FingerWidth(), $fn=50);									
							}
						}			
					}
					translate([-1, FingerWidth(-tolerance)*3/8, -1])
					{
						cube([HingeDepth(tolerance)+PlasticWidth(tolerance)*5, FingerWidth(tolerance)/4, FingerHeight(tolerance)-PlasticWidth(tolerance)-BandKeepAwayHeight(tolerance)]);
					}
					translate([-BandLength()/2,FingerWidth()/2-BandWidth()/2,FingerHeight()-BandKeepAwayHeight()+1])
					{
						BandKeepaway();
					}
				}
				difference()
				{
					translate([-1,0,-1])
					{
						cube([HingeDepth()-1, FingerWidth(), FingerHeight()/2+1]);
					}
					translate([FingerHeight()/2, 0, FingerHeight()/2])
					{
						rotate([-90,0,0])
						{
							cylinder(r=FingerHeight()/2, h=FingerWidth(), $fn=50);
						}
					}
				}
			}
			translate([FingerHeight()/4, FingerWidth(tolerance)*.75, FingerHeight()/2])
			{
				rotate([-90,0,0])
				{
					JointPin(tolerance);
				}
			}
			translate([FingerHeight()/4, FingerWidth(tolerance)*.25, FingerHeight()/2])
			{
				rotate([90,0,0])
				{
					JointPin(tolerance);
				}
			}
		}
		translate([HingeDepth()*2-1,-1,-1])
		{
			cube([HingeDepth()+1+JointClearance(), FingerWidth()+2, FingerHeight()+2]);
		}
	}
}


//Hinge();


module NegativeHinge(tolerance=0)
{
	union()
	{
		difference()
		{
			translate([-HingeDepth(),0,0])
			{
				cube([HingeDepth()*2-2.5, FingerWidth(), FingerHeight()]);
			}
			translate([-1, FingerWidth(-JointClearance())/4, -1])
			{
				cube([HingeDepth(JointClearance())+1,FingerWidth(JointClearance())/2, FingerHeight(JointClearance())]);
			}
			translate([-BandLength()/2,FingerWidth()/2-BandWidth()/2,FingerHeight()-BandKeepAwayHeight()+1])
			{
				BandKeepaway();
			}
			translate([-HingeDepth(JointClearance()), FingerWidth(-JointClearance())/4, -1])
			{
				cube([HingeDepth(JointClearance())+PlasticWidth(JointClearance())+3, FingerWidth(JointClearance())/2, FingerHeight(JointClearance())-PlasticWidth(JointClearance())-BandKeepAwayHeight(JointClearance())/2]);
			}
			translate([FingerHeight()/4, FingerWidth()-(FingerWidth()/4+PinClearance())+1, FingerHeight()/2])
			{
				rotate([-90,0,0])
				{
					JointPinHole();
				}
			}
			translate([FingerHeight()/4, FingerWidth()/4+PinClearance()-1, FingerHeight()/2])
			{
				rotate([90,0,0])
				{
					JointPinHole();
				}
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
		translate([-FingerHeight()/2.5, 0, 0])
		{
			CableGuide();
		}
	}
}

NegativeHinge();


