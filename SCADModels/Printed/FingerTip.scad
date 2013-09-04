use <../Purchased/RubberBand.scad>

function FingerTipLength()=25;
function FingerTipWidth()=20;
function FingerTipHeight()=10;

module FingerTip()
{
	difference()
	{
		cube([FingerTipLength(), FingerTipWidth(), FingerTipHeight()]);
		translate([-BandLength()/2,FingerTipWidth()/2-BandWidth()/2,FingerTipHeight()-BandKeepAwayHeight()+1])
		{
			BandKeepaway();
		}
	}
}

FingerTip();