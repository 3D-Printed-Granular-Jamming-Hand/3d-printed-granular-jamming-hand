use <../Tolerances/PlasticWidth.scad>
use <../Purchased/RubberBand.scad>
use <../Purchased/Bearing.scad>

//finger size values are based on the research in the "real hands" folder

function JointPinBaseDiameter(tolerance=0)=5+tolerance;
function JointPinEndDiameter(tolerance=0)=1+tolerance;
function GenericPinDiameter(tolerance=0)=2.5+tolerance;
function HingeDepth(tolerance=0)=11+tolerance;

function Clearance()=3;
function JointClearance()=1.5;

function FingerTipLength(tolerance=0)=17.4+tolerance;
function FingerMidLength(tolerance=0)=26.33+tolerance;
function FingerBaseLength(tolerance=0)=44.63+tolerance;

function FingerWidth(tolerance=0)=19.75+tolerance;
function FingerHeight(tolerance=0)=17+tolerance; // make shorter, usually 19.75 though







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
								difference()
								{
									translate([HingeDepth()*2-FingerHeight()/4,-PlasticWidth()*2-1,-1])
									{
										cube([FingerHeight()/2,FingerWidth()+2,FingerHeight()/4+1]);
									}
									translate([HingeDepth()*2-FingerHeight()/4,-PlasticWidth()*2-1,FingerHeight()/4])
									{
										rotate([-90,0,0])
										{
											cylinder(r=FingerHeight()/4,h=FingerWidth()+2, $fn=50);
										}
									}
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
		cube([HingeDepth()+1+Clearance(), FingerWidth()+2, FingerHeight()+2]);
	}
	}
}


//Hinge();


module JointPin(tolerance=0)
{

cylinder(FingerWidth(-tolerance)/4, JointPinBaseDiameter()/2, JointPinEndDiameter()/2, $fn=50);
			
}

module JointPinHole(tolerance=0)
{

cylinder(FingerWidth(-tolerance)/4+JointClearance(tolerance)+1, JointPinBaseDiameter()/2+JointClearance(tolerance), JointPinEndDiameter()/2, $fn=50);
			
}

module NegativeHinge(tolerance=5)
{

union()
{
	difference()
	{
		translate([-HingeDepth()-1.2,0,0.08])
		{
			#cube([HingeDepth()*2, FingerWidth(), FingerHeight()]);
		}
		translate([-1, FingerWidth(-tolerance)/4, -1])
		{
			cube([HingeDepth(tolerance)+1,FingerWidth(tolerance)/2+.5, FingerHeight(tolerance)]);
		}
translate([-BandLength()/2,FingerWidth()/2-BandWidth()/2,FingerHeight()-BandKeepAwayHeight()+1])
		
		{
			BandKeepaway();
		}
translate([-HingeDepth(tolerance),PlasticWidth()*1.5, -1])
		{
cube([HingeDepth(tolerance)+PlasticWidth(tolerance)+3, FingerWidth(tolerance)/2, FingerHeight(tolerance)-PlasticWidth(tolerance)-BandKeepAwayHeight(tolerance)/2]);
}

translate([FingerHeight()/4, FingerWidth(tolerance)*.6, FingerHeight()/2])
			{
				rotate([-90,0,0])
				{
					JointPinHole();
				}
			}

translate([FingerHeight()/4, FingerWidth(tolerance)*.2, FingerHeight()/2])
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
translate([-FingerHeight()/2.5, 0, FingerHeight()/6])
	{
		rotate([-90,0,0])
		{
		cylinder(r=GenericPinDiameter()/2, h=FingerWidth(), $fn=50);
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
			translate([FingerMidLength()/2+Clearance()+1,0,FingerHeight()-BandKeepAwayHeight()+1])
				cube([FingerHeight()/2, FingerHeight(), FingerHeight()/2+1]);
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
						translate([-HingeDepth()/2+Clearance()+1, 0, FingerHeight()/2])
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
  

FingerMid();

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
									translate([-1,-1,-1])
									{
										cube([FingerHeight()/4,FingerWidth()+2,FingerHeight()/4+1]);
									}
									translate([Clearance()+1,-1,FingerHeight()/2])
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


//Finger();

//translate([0,0,FingerBaseHeight()])
//rotate([0,180,0])
//Finger();
