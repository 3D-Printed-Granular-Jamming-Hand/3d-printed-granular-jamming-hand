// When calling this module, use toleranceMotor(boolean,boolean,boolean, number); 
// The first boolean determines the bolt direction(true is up, false is down) and 
// the second determines where the module is centered (true centers at the hub, 
// false centers at the motor mount).
// the third boolean determines whether to use the large cylindrical hub or the 
// small metal nub. 
// The Fourth number indicated the tolerance of the motor (default is .4 mm)

//THIS IS FOR IF YOU USE OTHER KINDS OF MOTORS, MOTOROUTCROP IS THE DISTANCE FROM THE MOUNTING PLATE TO THE BUISNESS END OF YOUR MOTOR, IF YOU EVER NEED TO SWITCH TO ANOTHER JUST CHANGE THIS VALUE TO THE ACTUAL VALUE

function StandardServoHeightAbvWings(tolerance=.6)=(StandardServoHeight()-(StandardServoWingsHeight()+StandardServoWingsDist()+tolerance*2));


function StandardServoOutcrop()= StandardServoCylinderHeight()+StandardServoHeightAbvWings();

function StandardServoWingLength()= (StandardServoLength()-StandardServoBaseLength())/2;


//for use when the motor is incorporated into parts
	//this is distance, the short way, from the edge of the motor to the center of the hub
function StandardServoCenterDist()=(StandardServoCylinderDiam()/2) + ((StandardServoLength()-StandardServoBaseLength())/2-StandardServoTolerance()*2); 

//basic motor shape
function StandardServoHeight()=42;
function StandardServoBaseLength()=42;
function StandardServoThickness()=21;

//wings for mounting
function StandardServoWingsHeight()=5.5;
function StandardServoLength()=55;
function StandardServoWingsDist()=26.5;
function StandardServoBoltHeadHeight()=1.4;

//cylinder on top of motor
function StandardServoCylinderHeight()=(46-38);
function StandardServoCylinderDiam()=21;
function StandardServoCylinderDist()=31;

//nub on top of motor
function StandardServoNubHeight()=5.85;
function StandardServoNubDiam(3dPrinterTolerance=.4)=6+3dPrinterTolerance;

//all bolts
function StandardServoBoltHeight()=13.5;
function StandardServoBoltDiam()=2.5;

//body bolts
function StandardServoBoltSideDist()=4.35;
function StandardServoBoltEdgeDist()=4.85;

//cylinder bolts
function StandardServoCylBoltDist()=7.62;

//hub for wires
function StandardServoHubHeight()=3.7;
function StandardServoHubWidth()=6;
function StandardServoHubLength()=3;
function StandardServoHubDist()=3;

//tolerance for servo
function StandardServoTolerance()=.6;

//When calling this module, use StandardServoMotor(boolean,boolean); The first boolean determines the bolt direction(true is up, false is down) and the second determines where the module is centered (true centers at the hub, false centers at the motor mount)

//defining a bolt
module StandardServoBolt(ServoTolerance=StandardServoTolerance())
{
	cylinder(h=StandardServoBoltHeight()+ServoTolerance, r=(StandardServoBoltDiam()+ServoTolerance)/2, $fn=100);
}

module bodyBolts(boltPlacementZ,ServoTolerance=StandardServoTolerance())
{
		translate([StandardServoBoltEdgeDist(),-StandardServoBoltSideDist(),boltPlacementZ])
		{
			StandardServoBolt(ServoTolerance);
		}
		
		translate([(StandardServoThickness()-StandardServoBoltEdgeDist()),-StandardServoBoltSideDist(),boltPlacementZ])
		{
			StandardServoBolt(ServoTolerance);
		}

		translate([StandardServoBoltEdgeDist(),(StandardServoBaseLength()+StandardServoBoltSideDist()),boltPlacementZ])
		{
			StandardServoBolt(ServoTolerance);
		}
		
		translate([(StandardServoThickness()-StandardServoBoltEdgeDist()),(StandardServoBaseLength()+StandardServoBoltSideDist()),boltPlacementZ])
		{
			StandardServoBolt(ServoTolerance);
		}
}

module StandardServoBlock(boltsUp=true, Cylinder=1, ServoTolerance=StandardServoTolerance()){
	union()
	{
//basic motor shape
		translate([-ServoTolerance, -ServoTolerance, -ServoTolerance])
		{
			cube([StandardServoThickness()+ServoTolerance*2, StandardServoBaseLength()+ServoTolerance*2, StandardServoHeight()+ServoTolerance*2]);
		}

//wings for mounting
		translate([-ServoTolerance, (-ServoTolerance+((StandardServoBaseLength()-StandardServoLength())/2)), StandardServoWingsDist()-ServoTolerance])
		{
			cube([StandardServoThickness()+ServoTolerance*2, StandardServoLength()+ServoTolerance*2, StandardServoWingsHeight()+ServoTolerance*2+StandardServoBoltHeadHeight()]);
		}

//determines if you should make the cylinder or a nub
if(Cylinder==1){
//cylinder on top of motor
		translate([StandardServoCylinderDiam()/2,StandardServoCylinderDist(),StandardServoHeight()])
		{
			cylinder(StandardServoCylinderHeight()+ServoTolerance*2, StandardServoCylinderDiam()/2+ServoTolerance, StandardServoCylinderDiam()/2+ServoTolerance, 0);

		}

//cylinder bolts
		translate([StandardServoThickness()/2,StandardServoCylinderDist()-StandardServoCylBoltDist(),(StandardServoHeight()+StandardServoCylinderHeight())])
		{
			StandardServoBolt(ServoTolerance);
		}

		translate([StandardServoThickness()/2,StandardServoCylinderDist()+StandardServoCylBoltDist(),(StandardServoHeight()+StandardServoCylinderHeight())])
		{
			StandardServoBolt(ServoTolerance);
		}

		translate([StandardServoThickness()/2+StandardServoCylBoltDist(),StandardServoCylinderDist(),(StandardServoHeight()+StandardServoCylinderHeight())])
		{
			StandardServoBolt(ServoTolerance);
		}

		translate([StandardServoThickness()/2-StandardServoCylBoltDist(),StandardServoCylinderDist(),(StandardServoHeight()+StandardServoCylinderHeight())])
		{
			StandardServoBolt(ServoTolerance);
		}
}else{
	if(Cylinder==2){
//nub on top of motor
		translate([StandardServoCylinderDiam()/2,StandardServoCylinderDist(),StandardServoHeight()])
		{
			cylinder(StandardServoNubHeight()+ServoTolerance*2, StandardServoNubDiam()/2+ServoTolerance, StandardServoNubDiam()/2+ServoTolerance, 0);

		}
}else{
	if(Cylinder==3){
	union()
	{
		translate([StandardServoCylinderDiam()/2,StandardServoCylinderDist(),StandardServoHeight()])
		{
			cylinder(StandardServoNubHeight()+ServoTolerance*2, StandardServoNubDiam()/2+ServoTolerance, StandardServoNubDiam()/2+ServoTolerance, 0);

		}

		translate([StandardServoThickness()/2+StandardServoTolerance(),StandardServoCylinderDist(),StandardServoHeight()+StandardServoNubHeight()+ServoTolerance*6])
		{
			Servo_wheel_4_arm_horn();
		}
	}
}
}	
}

		if(boltsUp==true){
			bodyBolts(StandardServoWingsDist()+StandardServoWingsHeight(),ServoTolerance);
		}else{
			bodyBolts(StandardServoWingsDist()-StandardServoBoltHeight(),ServoTolerance);
		}
		
//hub for wires
		translate([(StandardServoThickness()-(StandardServoHubWidth()+ServoTolerance))/2,(StandardServoBaseLength()+ServoTolerance),StandardServoHubDist()])
		{
			cube([StandardServoHubWidth()+ServoTolerance,StandardServoHubLength()+ServoTolerance,StandardServoHubHeight()+ServoTolerance]);
		}
	}
}



//making the motor
module StandardServoMotor(boltsUp=true, Cylinder=1, hornCentered=false, ServoTolerance=StandardServoTolerance())
{
	if(hornCentered==true){
		if(Cylinder==1){
			translate([-StandardServoThickness()/2,-StandardServoCylinderDist(),-(StandardServoHeight()+StandardServoCylinderHeight())-ServoTolerance*2])
			{
				StandardServoBlock(boltsUp,Cylinder,ServoTolerance);
			}
		}else{
			if(Cylinder==2){
			translate([-StandardServoThickness()/2,-StandardServoCylinderDist(),-(StandardServoHeight()+StandardServoNubHeight())-ServoTolerance*2])
			{
				StandardServoBlock(boltsUp,Cylinder,ServoTolerance);
			}
			}else{
				translate([-StandardServoThickness()/2,-StandardServoCylinderDist(),-(StandardServoHeight()+StandardServoNubHeight())-ServoTolerance*2-horn_height+.5])
				{
					StandardServoBlock(boltsUp,Cylinder,ServoTolerance);
				}
			}
			}
	}else{
		if(boltsUp == true){
			translate([ServoTolerance,(StandardServoLength()-StandardServoBaseLength())/2+ServoTolerance,(-StandardServoHeight()+(StandardServoHeight()-StandardServoWingsDist())-StandardServoWingsHeight()-ServoTolerance*4)])
			{	
				StandardServoBlock(boltsUp,Cylinder,ServoTolerance);
			}
		}else{
			translate([ServoTolerance,(StandardServoLength()-StandardServoBaseLength())/2+ServoTolerance,(-StandardServoHeight()+(StandardServoHeight()-StandardServoWingsDist())-StandardServoWingsHeight()-ServoTolerance*4)])
			{	
				StandardServoBlock(boltsUp,Cylinder,ServoTolerance);
			}
		}
	}

}


///YOU MIGHT WANT TO CLEAN UP THE PRONGEY GUY

//-------------------------------------------
//-- Futaba 3003 4-arm horn
//-------------------------------------------

//-- Futaba 3003 4-arm horn parameters
a4h_end_diam = 5;
a4h_center_diam = 10;
a4h_arm_length = 15;
a4h_drill_distance = 13.3;

horn_drill_diam = 2;
horn_drill_distance = 8;
horn_height = 4;



function horn_height()=4;

module horn4(h=5)
{
  union() {
    //-- Center part (is a square)
    cube([a4h_center_diam+0.2,a4h_center_diam+0.2,h],center=true);

    //-- Place the 4 arms in every side of the cube
    for ( i = [0 : 3] ) {
      rotate( [0,0,i*90])
      translate([0, a4h_center_diam/2, 0])
      horn4_arm(h);
    }
  }
}
module horn4_arm(h=5)
{
  translate([0,a4h_arm_length-a4h_end_diam/2,0])
  //-- The arm consist of the perimeter of a cylinder and a cube
  hull() {
    cylinder(r=a4h_end_diam/2, h=h, center=true, $fn=20);
    translate([0,1-a4h_arm_length+a4h_end_diam/2,0])
      cube([a4h_center_diam,2,h],center=true);
  }
}
module Servo_wheel_4_arm_horn()
{    
      horn4(h= horn_height);
}
//--------------------------------------------------------------
//-- Generic module for the horn's drills
//-- Parameters:
//--  d = drill's radial distance (from the horn's center)
//--  n = number of drills
//--  h = wheel height
//--------------------------------------------------------------
module horn_drills(d,n,h)
{
  union() {
    for ( i = [0 : n-1] ) {
        rotate([0,0,i*360/n])
        translate([0,horn_drill_distance,0])
        cylinder(r=horn_drill_diam/2, h=h+10,center=true, $fn=60);  
      }
  }
}




// StandardServoMotor (boolean,number,boolean, number); 
//The first boolean determines the bolt direction(true is up, false is down, default=true), 
//the first number determines whether to use the large cylindrical hub (1), the small metal nub (2), or the 4-arm horn (3)(default=1). The second boolean determines where the module is centered (true centers at the hub, false centers at the motor mount, default=false). The number indicated the tolerance of the motor (default is .4 mm)

StandardServoMotor(true,2,true,.4);






