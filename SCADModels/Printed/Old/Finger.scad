use <../Tolerances/PlasticWidth.scad>
use <../Purchased/RubberBand.scad>
use <../Purchased/Bearing.scad>

//finger size values are based on the research in the "real hands" folder

function FingerTipLength(tolerance=0)=17.4+tolerance;
function FingerTipWidth(tolerance=0)=19.75+tolerance;
function FingerTipHeight(tolerance=0)=19.75+tolerance; //not sure how tall to make the fingers so I'm just making height the same as width for now. When I say tall, I mean looking at it from the side what is length from underside (where the palm/fingerprints are) to the upper part (where the knuckes/nails are)

function JointPinDiameter(tolerance=0)=BearingInnerDiameter(tolerance);

function HingeDepth(tolerance=0)=11+tolerance;




function FingerMidLength(tolerance=0)=26.33+tolerance;
function FingerMidWidth(tolerance=0)=19.75+tolerance;
function FingerMidHeight(tolerance=0)=19.75+tolerance;


function FingerBaseLength(tolerance=0)=44.63+tolerance;
function FingerBaseWidth(tolerance=0)=19.75+tolerance;
function FingerBaseHeight(tolerance=0)=19.75+tolerance;



module Hinge(tolerance=0)
{
union()
{
	difference()
	{
	difference()
	{
		union()
		{
			translate([.5, FingerTipWidth(-tolerance)/4, 0])
			{
			cube([HingeDepth(tolerance)+1,FingerTipWidth(tolerance)/2, FingerTipHeight(tolerance)]);
			}
			translate([HingeDepth()+1,0,0])
			{
			cube([PlasticWidth(tolerance), FingerTipWidth(tolerance), FingerTipHeight(tolerance)]);
			}		
			
}
		translate([-1, FingerTipWidth(-tolerance)*3/8, -1])
		{
	cube([HingeDepth(tolerance)+PlasticWidth(tolerance)+3, FingerTipWidth(tolerance)/4, FingerTipHeight(tolerance)-PlasticWidth(tolerance)-BandKeepAwayHeight(tolerance)]);
		}

translate([-BandLength()/2,FingerTipWidth()/2-BandWidth()/2,FingerTipHeight()-BandKeepAwayHeight()+1])
		{
			BandKeepaway();
		}
	}
	difference()
	{
	translate([-1,0,-1])
	{
	cube([HingeDepth()+1, FingerTipWidth(), FingerTipHeight()/2+1]);
	}
	translate([FingerTipHeight()/2, 0, FingerTipHeight()/2])
	{
		rotate([-90,0,0])
		{
		cylinder(r=FingerTipHeight()/2, h=FingerTipWidth(), $fn=50);
}
		}
	}
	}
translate([FingerTipHeight()/4, 0, FingerTipHeight()/2])
			{
				rotate([-90,0,0])
				{
					cylinder(r=JointPinDiameter()/2, h=FingerTipWidth(), $fn=50);
				}
			}
}
}


//Hinge();


//things to do: round the hinges so they don't intefere, add the joint pins, see if the rubber band keepaway will work right
module NegativeHinge(tolerance=5)
{

union()
{
	difference()
	{
		translate([-HingeDepth()-1.2,0,0])
		{
			cube([HingeDepth()*2, FingerTipWidth(), FingerTipHeight()]);
		}
		translate([-1, FingerTipWidth(-tolerance)/4, -1])
		{
			cube([HingeDepth(tolerance)+1,FingerTipWidth(tolerance)/2, FingerTipHeight(tolerance)]);
		}
translate([-BandLength()/2,FingerTipWidth()/2-BandWidth()/2,FingerTipHeight()-BandKeepAwayHeight()+1])
		
		{
			BandKeepaway();
		}
translate([-HingeDepth(tolerance),FingerTipWidth()*1/4, -1])
		{
cube([HingeDepth(tolerance)+PlasticWidth(tolerance)+3, FingerTipWidth(tolerance)/2.5, FingerTipHeight(tolerance)-PlasticWidth(tolerance)-BandKeepAwayHeight(tolerance)/2]);
}

translate([FingerTipHeight()/4, -1, FingerTipHeight()/2])
			{
				rotate([-90,0,0])
				{
					cylinder(r=BearingOuterDiameter()/2, h=FingerTipWidth()+2, $fn=50);
				}
			}
difference()
	{
	translate([-1,-1,-1])
	{
	cube([HingeDepth()+2, FingerTipWidth()+2, FingerTipHeight()/2+1]);
	}
	translate([0, 0, FingerTipHeight()/2])
	{
		rotate([-90,0,0])
		{
		cylinder(r=FingerTipHeight()/2, h=FingerTipWidth(), $fn=50);
}
		}
	}
		
	}
translate([-FingerTipHeight()/4, FingerTipWidth()/4, FingerTipHeight()/2])
	{
		rotate([-90,0,0])
		{
		cylinder(r=JointPinDiameter()/2, h=FingerTipWidth()/2, $fn=50);
		}
	}
}
}

//NegativeHinge();

module FingerTip()
{
union()
{
	difference()
	{
		
			translate([HingeDepth()+1, 0, 0])
			{
				cube([FingerTipLength()-HingeDepth()/2-1, FingerTipWidth(), FingerTipHeight()]);
			}
			
		
	translate([HingeDepth()/2-PlasticWidth()/2, PlasticWidth(), -1])
	{
		cube([FingerTipLength()-PlasticWidth(), FingerTipWidth()-PlasticWidth()*2, FingerTipHeight()-PlasticWidth()-1]);
	}
	
	translate([FingerTipLength()+HingeDepth()/2-PlasticWidth()*1.5-1,FingerTipWidth()*3/8, FingerTipHeight()/5])
	{
		cube([PlasticWidth()*1.5+2, FingerTipWidth()/4, FingerTipHeight()/3]);
	}
}
		Hinge();
	}
{
	translate([FingerTipLength()+HingeDepth()/2-PlasticWidth()/1.5, 0, FingerTipHeight()/3])
			{
	rotate([-90,0,0])
	{
		cylinder(r=JointPinDiameter()/2, h=FingerTipWidth(), $fn=50);
	}
	}

	translate([HingeDepth()*2-PlasticWidth()*1.5,FingerTipWidth()/2,FingerTipHeight()-PlasticWidth()*2])
	{
	rotate([0,90,0])
	{

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
		
			translate([HingeDepth()+1, 0, 0])
			{
				cube([FingerMidLength()-HingeDepth()*2-1, FingerMidWidth(), FingerMidHeight()]);
			}
			
		
	translate([-PlasticWidth()/2, PlasticWidth(), -1])
	{
		cube([FingerMidLength()-PlasticWidth(), FingerMidWidth()-PlasticWidth()*2, FingerMidHeight()-PlasticWidth()-1]);
	}
	
	translate([FingerMidLength()-PlasticWidth()*1.5-1,FingerMidWidth()*3/8, FingerMidHeight()/4])
	{
		cube([PlasticWidth()*1.5+2, FingerMidWidth()/4, FingerMidHeight()/2]);
	}
}
		Hinge();
		translate([FingerMidLength(),0,0])
		{
			NegativeHinge();
		}
	}
{


	
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

union()
{
	difference()
	{
		
			translate([HingeDepth()+1, 0, 0])
			{
				cube([FingerBaseLength()-HingeDepth()*2-1, FingerBaseWidth(), FingerBaseHeight()]);
			}
			
		
	translate([-PlasticWidth()/2, PlasticWidth(), -1])
	{
		cube([FingerBaseLength()-PlasticWidth(), FingerBaseWidth()-PlasticWidth()*2, FingerBaseHeight()-PlasticWidth()-1]);
	}
	
	translate([FingerBaseLength()-PlasticWidth()*1.5-1,FingerBaseWidth()*3/8, FingerBaseHeight()/4])
	{
		cube([PlasticWidth()*1.5+2, FingerBaseWidth()/4, FingerBaseHeight()/2]);
	}
}
		Hinge();
		translate([FingerBaseLength(),0,0])
		{
			NegativeHinge();
		}
	}
{


	translate([HingeDepth()*2-PlasticWidth()*1.5,FingerBaseWidth()/2,FingerBaseHeight()-PlasticWidth()*2])
	{
	rotate([0,90,0])
	{

	}
}
  

}

translate([HingeDepth()*1.5,FingerMidWidth()/2,FingerMidHeight()-PlasticWidth()*2])
	{
	rotate([0,90,0])
	{

	
difference()
{
		cylinder(r=FingerBaseWidth()/8, h=FingerBaseLength()-HingeDepth()*3, $fn=50);
		translate([0,0,-1])
		{
			cylinder(r=FingerBaseWidth()/16, h=FingerBaseLength()-HingeDepth()*3+2, $fn=50);
		}
}
}}
}



//FingerBase();

//to check that the effective length is correct
//translate([HingeDepth()/2, 0, 0])
//{
//	#cube([FingerBaseLength(), 10, 10]);
//}


module Finger()
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

Finger();

//translate([0,0,FingerBaseHeight()])
//rotate([0,180,0])
//Finger();
