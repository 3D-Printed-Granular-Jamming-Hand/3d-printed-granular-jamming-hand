use <CommonModules.scad>
use <Mid.scad>
use <../Purchased/RubberBand.scad>
use <../Purchased/High_Low_Screw_As_Bolt.scad>


function PalmLength()=88.19;
function PalmWidth()=79+8;
function PalmHeight()=19.75;

function PalmHoleWidth()=FingerWidth()/8; //the width of the holes allowing the cables into the palm
function FingerSpace()=(PalmWidth()-FingerWidth()*4)/3+FingerWidth(); //spacing between fingers
function ThumbAngle()= 35; //angle of thumb attachment


function GuideAngle()=60;
function CableGuideHeight()=5;

function AirLineWidth(tolerance=1)=13+tolerance;



//THE SUPPORT MATERIAL DOESN'T CLEAR OUT WELL FROM THE NEW JOINT GUIDES -- REVISIT AGAIN?






//this makes the basic shape for the cable guides (the structures along the palm of the hand)
module BasePalmCableGuide(Length=10)
{
	translate([0,0,PlasticWidth()*2.3])
	{	
		rotate([0,90,0])
		{
			difference()
			{
				union()
				{
					translate([-CableGuideHeight()/2,0,0])
					{
						cylinder(r=PalmHoleWidth(), h=Length, $fn=50);
					}
					translate([-FingerHeight()/1.5+FingerWidth()/6-PlasticWidth()*1.2,-PalmHoleWidth(),0])
					{
						cube([CableGuideHeight()+PlasticWidth()*1.2, PalmHoleWidth()*2, Length]);
					}
				}
				union()
				{
					translate([-CableGuideHeight()/2,0,-1])
					{
						cylinder(r=PalmHoleWidth()/2, h=Length+2, $fn=50);
					}
					translate([-CableGuideHeight()*1.5,-PalmHoleWidth()/2,-1])
					{
						cube([CableGuideHeight(), PalmHoleWidth(), Length+2,]);
					}
					
					if (Length > 10)
					{
						for (i = [1:floor(Length/10)*2])
						{
							translate([-CableGuideHeight(),0,5.5*i])
							{
								rotate([0,90,0])
								{
									cylinder(r=PalmHoleWidth()/2, h=CableGuideHeight()*1.5, $fn=50);
								}
							}	
						}
					}
					else
					{
						translate([-CableGuideHeight(),0,4])
						{
							rotate([0,90,0])
							{
								cylinder(r=PalmHoleWidth()/2, h=CableGuideHeight()*1.5, $fn=50);
							}
						}	
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

//These are the angled guides
module AngledPalmCableGuide(Length=50, Angle=GuideAngle())
{
	translate([-Length*cos(Angle)-FingerWidth()*.3+FingerWidth()/2,-Length*sin(Angle)+FingerWidth()/4,0])
	{
		difference()
		{
			rotate([0,0,Angle])
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
		translate([-Length1-(Length2 * cos(GuideAngle())),-(Length2 * sin(GuideAngle())),0])
		{
			union()
			{
				translate([Length2*cos(GuideAngle())-FingerWidth()*.35,Length2*sin(GuideAngle())-FingerWidth()*.2,0])
				{
					union()	
					{
						BasePalmCableGuide(Length1);
						translate([-PalmHoleWidth()*2.5,-PalmHoleWidth()*2.5,0])
						{
							AngledPalmCableGuide(Length2, GuideAngle());								
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
	translate([PalmLength()-HingeDepth()-PlasticWidth()*2-1,FingerWidth()/2-PalmHoleWidth()/2,CableGuideHeight()*.5+PlasticWidth()+1])
	{
		cube([PlasticWidth()*2+2, PalmHoleWidth(), CableGuideHeight()*1.5]);
	}
}

//PalmHole();




//These are the bolts that will attach the hand to the forearm
module Bolt()
{
	translate([0,0,PalmHeight()-PlasticWidth()*4])
	{
		rotate([0,180,0])
		{
			#HiLoBolt(.4, PlasticWidth()*1.6+BandKeepAwayHeight()+1);
		}
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
					translate([PalmLength()*.4, PalmWidth()/2, -1])
					{
						cylinder(r=AirLineWidth()/2, h=PalmHeight(), $fn=6);
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
				}
				translate([PlasticWidth()*2+6,PalmWidth()/2+17,-PalmHeight()+FingerHeight()])
				{
					rotate([0,0,ThumbAngle()])
					{
						cube([PalmLength()*.75,PalmWidth()-PlasticWidth()*4, PalmHeight()]);	
					}
				}
			}				
			translate([PlasticWidth()-24.5,PalmWidth()/2-1,-PalmHeight()+FingerHeight()-1])
			{
				rotate([0,0,ThumbAngle()])
				{
					cube([PalmLength()*1.5,PalmWidth()-PlasticWidth()*4, PalmHeight()+2]);					
				}
			}
			translate([0,PalmWidth(),-3])
			{
				cube([PalmLength(),PalmWidth()-PlasticWidth()*4, PalmHeight()+2]);	
			}	
			translate([14,PalmWidth()*.745,-5])
			{
				rotate([0,0,180])
				{
					cube([PalmLength(),FingerWidth()-1, PalmHeight()+10]);					
				}
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
			translate([15,PalmWidth()/2+FingerWidth()/3,0])
				{
					rotate([0,0,180])
					{
						translate([10,-15,0])
						{
							difference()
							{
								NegativeHinge();
								difference()
								{
									translate([-FingerWidth()-2,-1,-2])
									{
										cube([FingerWidth(),FingerWidth()+2, FingerWidth()+1]);
									}
									translate([-FingerWidth()/8,FingerWidth()+1,FingerWidth()/2])
									{
										rotate([90,0,0])
										{
											cylinder(r=FingerWidth()/2, h=FingerWidth()+2);
										}
									}			
								}									
							}
						}
					}
				}
				translate([0,0,PalmHeight()-PlasticWidth()*2-BandKeepAwayHeight()-.3])
				{
					cube([PalmLength()/8,PalmWidth()/1.9, PlasticWidth()+BandKeepAwayHeight()]);
				}
			}
		}

//these numbers are a little hacky	
		PalmCableGuide(PalmLength()-HingeDepth());
		translate([0,FingerSpace(),0])
		{
			BentPalmCableGuide(10,FingerSpace()*.8,52.8);
		}
		translate([0,FingerSpace()*2,0])
		{
			BentPalmCableGuide(10,FingerSpace()*1.7,42.7);
		}
		translate([0,FingerSpace()*3,0])
		{
			BentPalmCableGuide(10,FingerSpace()*2.6,32.6);
		}
//thumb guide
		translate([19,PalmWidth()/2-6,0])
		{
			AngledPalmCableGuide(13, 65);
		}
		translate([12,PalmWidth()/2+5,0])
		{
			AngledPalmCableGuide(10, 130);
		}
		translate([22-10.9,PalmWidth()/3.6,0])
		{
			AngledPalmCableGuide(15,0);
		}
		translate([-PalmLength()/4.5,0,-PalmHeight()+FingerHeight()])
		{
			cube([PalmLength()/4.5,PlasticWidth(), PalmHeight()]);
		}
//forearm mount		
		difference()
		{
			translate([-PalmLength()/4.5,0,PalmHeight()-PlasticWidth()*2-BandKeepAwayHeight()-.3])
			{
				cube([PalmLength()/4.5,PalmWidth()/2, PlasticWidth()+BandKeepAwayHeight()]);
			}
			translate([-PalmWidth()/16,PalmWidth()/2.5,0])
			{
				Bolt();
			}
			translate([-PalmWidth()/6,PalmWidth()/2.5,0])
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
		}
	}
}



	


Palm();



