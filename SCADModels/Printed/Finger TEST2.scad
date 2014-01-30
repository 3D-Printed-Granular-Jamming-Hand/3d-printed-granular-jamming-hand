use <../Tolerances/PlasticWidth.scad>
use <../Purchased/RubberBand.scad>
use <../Purchased/Bearing.scad>

//finger size values are based on the research in the "real hands" folder

function FingerTipLength(tolerance=0)=17.4+tolerance;
function FingerTipWidth(tolerance=0)=19+tolerance;
function FingerTipHeight(tolerance=0)=19.75+tolerance; //not sure how tall to make the fingers so I'm just making height the same as width for now. When I say tall, I mean looking at it from the side what is length from underside (where the palm/fingerprints are) to the upper part (where the knuckes/nails are)

function JointPinDiameter(tolerance=0)=BearingInnerDiameter(tolerance);
function HingeDepth(tolerance=0)=11+tolerance;

function Clearance()=3;


function FingerMidLength(tolerance=0)=26.33+tolerance;
function FingerMidWidth(tolerance=0)=19.75+tolerance;
function FingerMidHeight(tolerance=0)=19.75+tolerance;


function FingerBaseLength(tolerance=0)=44.63+tolerance;
function FingerBaseWidth(tolerance=0)=19.75+tolerance;
function FingerBaseHeight(tolerance=0)=19.75+tolerance;



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
						translate([.5, FingerTipWidth(-tolerance)/4, 0])
						{
							difference()
							{
								cube([HingeDepth(tolerance)*2+1,FingerTipWidth(tolerance)/2, FingerTipHeight(tolerance)]);
								difference()
								{
									translate([HingeDepth()*2-FingerTipHeight()/4,-PlasticWidth()*2-1,-1])
									{
										cube([FingerTipHeight()/2,FingerTipWidth()+2,FingerTipHeight()/4+1]);
									}
									translate([HingeDepth()*2-FingerTipHeight()/4,-PlasticWidth()*2-1,FingerTipHeight()/4])
									{
										rotate([-90,0,0])
										{
											cylinder(r=FingerTipHeight()/4,h=FingerTipWidth()+2, $fn=50);
										}
									}
								}
							}
						}
						translate([HingeDepth()+1+Clearance(),0,FingerTipHeight()/2])
						{
							cube([HingeDepth(tolerance), FingerTipWidth(tolerance), FingerTipHeight(tolerance)/2]);
						}		
						translate([HingeDepth(tolerance)*2+Clearance(), 0, FingerTipHeight()/2])
						{
							rotate([-90,0,0])
							{
								cylinder(r=FingerTipHeight()/2, h=FingerTipWidth(), $fn=50);									
							}
						}			
					}
					translate([-1, FingerTipWidth(-tolerance)*3/8, -1])
					{
						cube([HingeDepth(tolerance)+PlasticWidth(tolerance)*5, FingerTipWidth(tolerance)/4, FingerTipHeight(tolerance)-PlasticWidth(tolerance)-BandKeepAwayHeight(tolerance)]);
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
	translate([HingeDepth()*2-1,-1,-1])
	{
		cube([HingeDepth()+1+Clearance(), FingerTipWidth()+2, FingerTipHeight()+2]);
	}
	}
}


//Hinge();



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
translate([-HingeDepth(tolerance),PlasticWidth()*1.5, -1])
		{
cube([HingeDepth(tolerance)+PlasticWidth(tolerance)+3, FingerTipWidth(tolerance)/2, FingerTipHeight(tolerance)-PlasticWidth(tolerance)-BandKeepAwayHeight(tolerance)/2]);
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
translate([-FingerTipHeight()/4, 0, FingerTipHeight()/6])
	{
		rotate([-90,0,0])
		{
		cylinder(r=JointPinDiameter()/2, h=FingerTipWidth(), $fn=50);
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
			union()
			{
				translate([HingeDepth()+2+FingerTipLength()/2.5+1, 0, 1])
				{
					cube([FingerTipLength()-HingeDepth()-4, FingerTipWidth(), FingerTipHeight()-1]);

				}
				Hinge();
			}			
			
			translate([FingerTipLength()+HingeDepth()/2-PlasticWidth()*1.5-1,FingerTipWidth()*3/8, FingerTipHeight()-FingerTipHeight()/3-PlasticWidth()])
			{
				cube([PlasticWidth()*1.5+2, FingerTipWidth()/4, FingerTipHeight()/3]);
			}
		}
			translate([FingerTipLength()+HingeDepth()/2-PlasticWidth()/1.5, 0, FingerTipHeight()*.835-PlasticWidth()])
		{
			rotate([-90,0,0])
			{
				cylinder(r=JointPinDiameter()/2, h=FingerTipWidth(), $fn=50);				
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
			translate([FingerMidLength()/2+Clearance()+1,0,FingerTipHeight()-BandKeepAwayHeight()+1])
				cube([FingerMidHeight()/2, FingerMidHeight(), FingerMidHeight()/2+1]);
		}
		translate([FingerMidLength(),0,0])
		{
			difference()
			{
				NegativeHinge();
				difference()
				{
					translate([-HingeDepth()-2,-1,-1])
					{
						cube([FingerMidHeight()/2+1, FingerMidHeight()+2, FingerMidHeight()/2+1]);
					}
					translate([-HingeDepth()/2+Clearance()+1, 0, FingerMidHeight()/2])
					{
						rotate([-90,0,0])
						{
							cylinder(r=FingerTipHeight()/2, h=FingerTipWidth(), $fn=50);
						}
					}					
				}
				translate([-FingerMidLength()-HingeDepth()/2+1,-1,0])
				{
					cube([FingerMidHeight(),FingerMidHeight()+2,FingerMidHeight()+1]);	
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
	union()
	{
		difference()
		{
			translate([HingeDepth()*2-PlasticWidth()/2, 0, 0])
			{
				difference()
				{
					cube([FingerBaseLength()-HingeDepth()*3+PlasticWidth()/2, FingerTipWidth(), FingerBaseHeight()]);
					difference()
								{
									translate([-1,-1,-1])
									{
										cube([FingerTipHeight()/4,FingerTipWidth()+2,FingerTipHeight()/4+1]);
									}
									translate([Clearance()+1,-1,FingerTipHeight()/2])
									{
										rotate([-90,0,0])
										{
											cylinder(r=FingerTipHeight()/2,h=FingerTipWidth()+2, $fn=50);
										}
									}
								}
				}
			}
			translate([-PlasticWidth()/2, PlasticWidth(), -1])
			{
				cube([FingerBaseLength()-PlasticWidth(), FingerBaseWidth()-PlasticWidth()*2, FingerBaseHeight()-PlasticWidth()-1]);
			}
		}
		Hinge();
		translate([FingerBaseLength(),0,0])
		{
			NegativeHinge();
		}
		translate([FingerBaseLength()/2, 0, FingerTipHeight()/6])
		{
			rotate([-90,0,0])
			{
				//cylinder(r=JointPinDiameter()/2, h=FingerTipWidth(), $fn=50);
			}
		}
		translate([FingerBaseLength()*.7, 0, FingerTipHeight()/2])
		{
			rotate([-90,0,0])
			{
				//cylinder(r=JointPinDiameter()/2, h=FingerTipWidth(), $fn=50);
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

module FingerBent()
{
	union()
	{
		translate([FingerMidLength()+FingerBaseLength()-5,0,14.5])
		{
			rotate([0,90,0])
			color("blue")
			FingerTip();
		}
		translate([FingerBaseLength(),0,0])
		{
			FingerMid();
		}
	translate([59.5,0,-40])
	rotate([0,-90,0])
	color("green")
	FingerBase();
	}
}

//FingerBent();



Finger();

//translate([0,0,FingerBaseHeight()])
//rotate([0,180,0])
//Finger();
