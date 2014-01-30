use <../Tolerances/3dPrinterTolerance.scad>

//sizes for the band assume that we use half inch bands

function bandsize() = 1/2; //this is bandsize in inches, if you want to use a different size band this is the only variable you change

function mm(inch)=inch*25.4; //this just converts inches to mm, mm is the default size for openSCAD

//checking to make sure the function works right. Result comes up in the window below your model.
echo("CONVERTING 1 INCH TO MM", mm(1));
//yep, 1 inch is 25.4 mm.

function circumference()= mm(bandsize())*PI; //this just calculates circumference in mm

//checking to make sure circumference works right.
echo("CIRCUMFERENCE (in mm) IS", circumference());
//yep, 19.9491 mm.


function BandWidth(tolerance=3dPrinterTolerance())=circumference()/6+tolerance*2; //slightly narrower than it is long
function BandLength(tolerance=3dPrinterTolerance())=circumference()/3+tolerance*2;
echo("BANDLENGTH (in mm) IS", BandLength());
function BandThickness(tolerance=3dPrinterTolerance())=1+tolerance; //just measured the rubber bands they are in fact 1 mm wide
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
	//cube([20,10,10], center=true);
	translate([-5,-4,1])
	{
	//BandKeepaway();
	}
}