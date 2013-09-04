use <../Tolerances/3dPrinterTolerance.scad>

function BandWidth(tolerance=3dPrinterTolerance())=4+tolerance*2;
function BandLength(tolerance=3dPrinterTolerance())=10+tolerance*2;
function BandThickness(tolerance=3dPrinterTolerance())=1+tolerance;

function BandKeepAwayHeight(tolerance=3dPrinterTolerance())=BandThickness(tolerance)*3;

module Band(tolerance=3dPrinterTolerance())
{
	difference()
	{
		cube([BandLength(tolerance), BandWidth(tolerance), BandThickness(tolerance)]);
		translate([BandThickness(tolerance),BandThickness(tolerance),-1])
		{
			cube([BandLength(tolerance)-BandThickness(tolerance)*2, BandWidth(tolerance)-BandThickness(tolerance)*2, BandThickness(tolerance)+2]);
		}
	}
}

//Band();



module BandKeepaway(tolerance=3dPrinterTolerance())
{
	union()
	{
		Band(tolerance);
		translate([-BandThickness(tolerance),-BandThickness(tolerance),0])
		{
			cube([BandThickness(tolerance)+.01, BandWidth(tolerance)+BandThickness(tolerance)*2, BandKeepAwayHeight(tolerance)]);
		}
		translate([BandLength(tolerance)-.01,-BandThickness(tolerance),0])
		{
			cube([BandThickness(tolerance)+.01, BandWidth(tolerance)+BandThickness(tolerance)*2, BandKeepAwayHeight(tolerance)]);
		}
		translate([0,-BandThickness()+.01,0])
		{
			cube([BandLength(tolerance)+.01, BandThickness(tolerance)+.01, BandThickness(tolerance)*3]);
		}
		translate([0,BandWidth(tolerance)-.01,0])
		{
			cube([BandLength(tolerance)+.01, BandThickness(tolerance), BandThickness(tolerance)*3]);
		}
	}
}

BandKeepaway();




//test
difference()
{
	//cube([20,15,10], center=true);
	translate([-5,-4,1])
	{
	//BandKeepaway();
	}
}