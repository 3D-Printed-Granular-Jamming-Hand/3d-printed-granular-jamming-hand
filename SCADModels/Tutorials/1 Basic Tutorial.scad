//OpenSCAD basics:

//	"//" is how you denote comments.

//			declare any variables you have at the very top. Always try to use variables rather than typing numbers into your code, because if for some reason height, etc changes, it's much easier to change this way.

length = 5;
height = 2;
width = 4;
radius = 3;

//			the default unit in OpenSCAD is millimeters, so if your measurements are in, say, inches, you will have to make a function to convert your lengths.

function mm(i) = i*25.4;

//			if you are making small features and your cylinders all look like pentagons, use $fn to change the number of fragments the computer displays and make your curves curvier

$fn=50;

//			F5 will update your model for viewing (so every time you change something, hit F5), F6 will render your model and it takes longer, but you need to hit F6 to render the model before exporting it for printing.

//			cylinders have four arguments, first height, then radius at the bottom, then radius at the top, then center (pretty much always 0)

///			(remove the comment to see this):
//cylinder(mm(height), mm(radius), mm(radius), 0);

//			changing the radii makes the cylinder have sloped sides, like a cone

//cylinder(mm(height), mm(radius), mm(radius/2), 0);

//			if you are just making a basic cylinder without sloped sides, you can use this shortcut (where h is desired height and r is desired radius)
//cylinder(h=mm(height), r=mm(radius));

//			cubes are considered vectors, so you need both parenthesis and brackets, also while cylinders take the height argument first, cubes do it last. So if you have any issues with cubes, check those two things first. The arguments for a cube are: width, length, and height.

//cube([mm(width), mm(length), mm(height)]);

//			combining things is done using "union" 
//				note: everything but the functions (i.e. union, subtraction) gets ended in a semicolon, if you have an error somewhere and don't know what's wrong, you probably forgot to put a semicolon at the end of an object.

//union()
//{
//	cylinder(mm(height), mm(radius), mm(radius/2), 0);
//	cube([mm(width), mm(length), mm(height)]);
//}

//		cutouts are done using "difference"

//difference()
//{
//	cylinder(mm(height), mm(radius), mm(radius/2), 0);
//	cube([mm(width), mm(length), mm(height)]);
//}

//		a few notes about difference, you can put any number of arguments into either union or difference. For union all of them will be added. For difference, all after the first will be subtracted from the first.

//		Also, for difference, if you subtract something of the same thickness from a part, you will see a hazy green thing, this is because it doesn't quite cut through all the way. To combat this just add 2mm to the thickness of your cut and offset by -1mm

//difference()
//{
//	cylinder(mm(height), mm(radius), mm(radius/2), 0);
//	translate([0,0,-1])
//	{
//		cube([mm(width), mm(length), mm(height)+2]);
//	}
//}

//		if you need to see what you're doing, just add a number sign in front of an element to highlight it.

//difference()
//{
//	cylinder(mm(height), mm(radius), mm(radius/2), 0);
//	translate([0,0,-1])
//	{
//		#cube([mm(width), mm(length), mm(height)+2]);
//	}
//}

//		To move objects, you can either translate or rotate them. Translate slides them around horizontally/vertically, and rotate spins them around an axis. When you're nesting translate and rotate, make sure you do it in the right order. Remember, OpenSCAD (and all scripting/programming languages) performs operations in the innermost set of brackets first.

//		EXAMPLE: you want a square rotated 45 degrees and slid along the positive x axis. If you rotate, then translate, it will be where you planned. If you translate, then rotate, it will be off where you didn't expect it. So if you run into a problem with translation and rotation, check that first.


//		Rotate, then translate:

//translate([mm(7),0,0])
//{
//	rotate([0,0,45])
//	{
//		cube([mm(width), mm(length), mm(height)+2]);
//	}
//}

//		Translate, then rotate:

//rotate([0,0,45])
//{
//	translate([mm(7),0,0])
//	{
//		cube([mm(width), mm(length), mm(height)+2]);
//	}
//}

//		If you're doing a lot of complex and repetitive stuff, rather than copying/pasting code, use modules. To make a module, use the module function and pick a name

//module hole()
//{
//	cylinder(mm(height)+2, mm(.5), mm(.5), 0);
//}

//to see a module, use its name:

//hole();

//		to use a module just call it within something else (you have to leave the hole declaration in (as in, don't comment it back out) for this to work)

//difference()
//{
//	cylinder(mm(height), mm(radius), mm(radius/2), 0);
//	hole();
//}

//		When indenting your code you want to increase one indent for each function, and you want brackets to have their own line (like what I've been doing). This just makes it much easier to follow, and to see if you're missing a bracket or something.

//		Also variables are your friends, try to put as much as you can in terms of variables because if, say, you have a hole at 1/2 length, and your length changes, the hole will move as well and you won't have to track it down in the code and manually change the offset.

//		honestly that's pretty much all I'd have to tell you about the basics, there's a cheatsheet at http://www.openscad.org/cheatsheet/, with the supported operations listed, which is good if you forget what order the arguments go in or something, and there's a really detailed page of some of the more complex operations at http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language



