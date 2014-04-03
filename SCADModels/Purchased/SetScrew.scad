//this is modelling a 4/40 x 1/8 set screw

function SetScrewDiameter(3dPrinterTolerance=0)= 2.8 + 3dPrinterTolerance*2;
function SetScrewLength(3dPrinterTolerance=0)= 3.26 + 3dPrinterTolerance;

module SetScrew(3dPrinterTolerance=0)
{
	rotate([0,90,0])
	{
		translate([0,0,-SetScrewLength(3dPrinterTolerance)])
		{
			cylinder(h=SetScrewLength(3dPrinterTolerance), r=SetScrewDiameter(3dPrinterTolerance)/2, $fn=30);			
	}	}
}



SetScrew();