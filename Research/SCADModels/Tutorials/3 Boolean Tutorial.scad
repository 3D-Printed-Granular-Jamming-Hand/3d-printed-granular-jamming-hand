//Boolean tutorial: Booleans are about as complex as you ever need to get in openSCAD and honestly I doubt we'll need them for the project. But just in case we do, here is how you do it.

//declare your module, naming the boolean in the arguments
module circlesquare(Circle=true)
{
//declare if statement, = denotes setting something to equal something else, == denotes asking if something equals something else
	if(Circle==true)
	{
//put your argument for a true statement inside the true part
		cylinder(h=5,r=5, center=true);
		//(all center=true does is center the shape on the origin)
	}
	else
	{
//put your argument for a false statement inside the else part
		cube([5,5,5],center=true);
	}
}

//that's it! try toggling this from true to false
circlesquare(true);