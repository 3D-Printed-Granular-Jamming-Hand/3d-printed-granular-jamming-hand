use <../Purchased/RubberBand.scad>
use <CommonModules.scad>

//finger size values are based on the research in the "real hands" folder

function FingerTipLength(tolerance=0)=17.4+tolerance;
function FingerMidLength(tolerance=0)=36.33+tolerance;
function FingerBaseLength()=44.63;


//get it to support tolerance properly again (probably broke this a little)
//modify it so all fingers work from the same file


//knock out all the mid stuff




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
		Hinge();
		translate([FingerMidLength(),0,0])
		{
			NegativeHinge();					
			
		}		
		difference()
		{
			translate([FingerMidLength()/1.8,0,0])
			{
				cube([FingerMidLength()/6,FingerWidth(),FingerHeight()]);
			}
			translate([FingerMidLength()/1.8-1,FingerWidth()/4,-1])
			{
				cube([HingeDepth()+PlasticWidth()*5, FingerWidth()/2, FingerHeight()-PlasticWidth()-BandKeepAwayHeight()+1]);
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
	union()
	{
		difference()
		{
			translate([HingeDepth()*2-PlasticWidth()/2, 0, 0])
			{
				difference()
				{
					cube([FingerBaseLength()-HingeDepth()*3+PlasticWidth()/2, FingerWidth(), FingerHeight()]);
					difference()
					{
						translate([-2.5,-1,-1])
						{
							cube([FingerHeight()/4,FingerWidth()+2,FingerHeight()/4+1]);
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
			translate([-PlasticWidth()/2, PlasticWidth(), -1])
			{
				cube([FingerBaseLength()-PlasticWidth(), FingerWidth()-PlasticWidth()*2, FingerHeight()-PlasticWidth()-1]);
			}
		}
		Hinge();
		translate([FingerBaseLength(),0,0])
		{
			NegativeHinge();
		}
	}
}




//FingerBase();

//to check that the effective length is correct
//translate([HingeDepth()/2, 0, 0])
//{
//	#cube([FingerBaseLength(), 10, 10]);
//}


module Thumb()
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

module ThumbBent()
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

//ThumbBent();


Thumb();

//translate([0,0,FingerBaseHeight()])
//rotate([0,180,0])
//Finger();
