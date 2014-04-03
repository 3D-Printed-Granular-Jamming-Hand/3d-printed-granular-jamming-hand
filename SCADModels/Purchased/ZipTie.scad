function ZipTieWidth(3dPrinterTolerance=.4)=2.5+3dPrinterTolerance;
function ZipTieHeight(3dPrinterTolerance=.4)=1+3dPrinterTolerance;
function ZipTieLength(3dPrinterTolerance=.4)=100+3dPrinterTolerance;

module ZipTie(3dPrinterTolerance=.4)
{
	cube([ZipTieWidth(3dPrinterTolerance), ZipTieHeight(3dPrinterTolerance),ZipTieLength(3dPrinterTolerance)]);
}

ZipTie(.4);
