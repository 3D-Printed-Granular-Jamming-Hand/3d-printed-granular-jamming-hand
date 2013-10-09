use <../Tolerances/PlasticWidth.scad>
use <../Purchased/RubberBand.scad>

//finger size values are based on the research in the "real hands" folder

function FingerTipLength()=44.63;
function FingerTipWidth()=19.75;
function FingerTipHeight()=19.75; //not sure how tall to make the fingers so I'm just making height the same as width for now. When I say tall, I mean looking at it from the side what is length from underside (where the palm/fingerprints are) to the upper part (where the knuckes/nails are)

module HingeAllowance()
{
	rotate([0,45,0])
	{
		translate([-FingerTipWidth(), -1, -PlasticWidth()-BandKeepAwayHeight()])
		{
			cube([FingerTipLength(), FingerTipWidth()+2, FingerTipHeight()]);
		}
	}
}

//HingeAllowance();


module FingerTipBlock()
{
	difference()
	{
		difference()
		{
			cube([FingerTipLength(), FingerTipWidth(), FingerTipHeight()]);
			translate([-BandLength()/2,FingerTipWidth()/2-BandWidth()/2,FingerTipHeight()-BandKeepAwayHeight()+1])
			{
				BandKeepaway();
			}
		}
	translate([-PlasticWidth(), PlasticWidth(), -1])
	{
		cube([FingerTipLength()-PlasticWidth(), FingerTipWidth()-PlasticWidth()*2, FingerTipHeight()-PlasticWidth()-BandKeepAwayHeight()-1]);
	}
		HingeAllowance();
	}
}

FingerTipBlock();



