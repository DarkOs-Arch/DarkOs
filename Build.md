# Requirements
### in order to build an iso , it is necessary to have the following packages.
- archiso version '52-1' for (One Hell, Schmedding)
- archiso version '46-1' for (SooperTrack)
- mkinitcpio-archiso

### How To Build 
- Go to installation_scripts and run (Build.sh) As root , this will create a new chroot environment that will install the required packages from packages.x84_64 and will setup the environment and then it will build airootfs image and package it into an iso
- To Configure As you like , change packages in packages in packages.x84_64 and add config files in airootfs/etc.
- DO NOT REMOVE Packages List Before (###Xorg) in (OneHell,SooperTrack) Otherwise this will result into errors when building. In Schmedding All Those Packages Are Necessary To Build The Iso.  
- 
