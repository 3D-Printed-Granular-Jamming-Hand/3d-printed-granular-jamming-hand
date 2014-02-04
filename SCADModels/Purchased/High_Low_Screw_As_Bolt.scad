//This is modelling a plastic screw being used as a bolt, and it's got a thicker bit so that it can slide through one side of the grip and then grab onto the other

function HiLoBoltOuterDiameter(3dPrinterTolerance=.4) = 4.5 + 3dPrinterTolerance*2;
function HiLoBoltDiameter(3dPrinterTolerance=.4)= 3.3 + 3dPrinterTolerance*2;
function HiLoBoltLength(3dPrinterTolerance=.4)= 22 + 3dPrinterTolerance;
function HiLoBoltHeadDiameter(3dPrinterTolerance=.4)= 6.7 + 3dPrinterTolerance*2;
function HiLoBoltHeadHeight(3dPrinterTolerance=.4)= 2.5 + 3dPrinterTolerance;

//err on the side of larger tolerances for bolts

module HiLoBolt(3dPrinterTolerance=.4, PlasticWidth=4.2)
{
	union()
	{
		translate([0,0,-HiLoBoltLength(3dPrinterTolerance)])
		{
			union()
			{
				cylinder(h=HiLoBoltLength(3dPrinterTolerance), r=HiLoBoltDiameter(3dPrinterTolerance)/2, $fn=30);
				translate([0,0,HiLoBoltLength(3dPrinterTolerance)-(PlasticWidth+2)])
				{
					cylinder(h=PlasticWidth+2, r=HiLoBoltOuterDiameter(3dPrinterTolerance)/2, $fn=30);
				}
			}
		}
		cylinder(h=HiLoBoltHeadHeight(3dPrinterTolerance), r=HiLoBoltHeadDiameter(3dPrinterTolerance)/2,$fn=30);
	}
}



HiLoBolt(.4,4.2);