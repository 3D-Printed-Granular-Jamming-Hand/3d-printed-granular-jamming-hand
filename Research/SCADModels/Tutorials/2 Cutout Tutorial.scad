//
//TWO WAYS TO IMPORT VITAMINS FOR CUTOUTS
//






//First way (which I would reccomend):


//use the "use" command to pull in .scad files

//The "../" indicates going up one folder from the folder in which your file (in this case, "motor cutout test" is stored. After you are up to a folder that can branch back down the location of your desired STL, just start using folder names.

//Put all use commands at the very top of the document, with variables, constants, etc

use <../Purchased/ServoMotor.scad>
//So what this does is go from "Tutorials", up one folder into "SCADModels", and then down one into "Purchased" and selects the ServoMotor.scad

//You can then call modules from the .scad file you have pulled in. They behave exactly like modules usually do and you can even feed in variables. (the motor we pulled in is here displayed in green, check out how you can change the values to true or false to center it in different ways and change the orientation of the screws)

translate([0,75,0])
{
	color("Green")
	StandardServoMotor(true,1,true,.4);
}

//To make your cut just treat the module as you would any other (The translates and rotates and such are just to make everything easily visible for this example)

module test1()
{

	difference()
	{
		translate([-13,-40,-10])
		{
			cube([25, 60, 15]);
		}
	StandardServoMotor(true,1,true,.4);
	}
}

translate([50,50,0])
{
	rotate([180, 0, 0])
	{
		test1();
	}
}

//The cutout we made with this motor is displayed next to the green motor.


//As you can see this is quite powerful because it allows you to pull in only parts of files, and also allows you to input variables right here in this file.




/////////////////////////////////////////////////////////////////////





//Second way (which I would probably not reccomend for .scad files, but is useful if a file has been made in Solidworks or wherever else):




//Just start by doing a regular cut

module test2()
{
	difference()
	{
		translate([-2,-10,35])
		{
			cube([25, 60, 15]);
		}

//this is how you import STL files. Unlike importing .scad files, which you call at the top and then call as modules in your code, you only need to call the file once, with the command "import", and you do it within your code.

//Again, the "../" indicates going up one folder from the folder in which your file (in this case, "motor cutout test" is stored. After you are up to a folder that can branch back down the location of your desired STL, just start using folder names.
		translate([11,30,45])
		{
			import("../Purchased/ServoMotor.stl");
		}

	}
}

//here I just flipped the result over so it has a flat surface to print on
translate([39,-50,45])
{
	rotate([180, 0, 0])
	{
		test2();
	}
}

//Here is just so you can see what the motor stl looks like. It is in blue, next to the cutout that it was used to make.

translate([0,-50,0])
{
	color("Blue")
	import("../Purchased/ServoMotor.stl");

}



