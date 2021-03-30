#!/bin/bash
#set -e
# Author	:	Erik Dubois
# Modified By: Ybenel(r2dr0dn) Aka pOmS
# set our parameters
buildFolder="$HOME/DarkOs/DarkOs_Build"
outFolder="$HOME/DarkOs/DarkOs-Out"

echo
echo "################################################################## "
tput setaf 2;echo "Phase 1 : get the latest bashrc from github";tput sgr0
echo "################################################################## "
echo
# echo "Removing old files/folders from /etc/skel"
# rm -rf ../archiso/airootfs/etc/skel/.* 2> /dev/null
# echo "getting .bashrc from arcolinux-root"
# add bashrc later
#wget https://raw.githubusercontent.com/arcolinux/arcolinux-root/master/etc/skel/.bashrc-latest -O ../archiso/airootfs/etc/skel/.bashrc
echo ".bashrc copied to /etc/skel"

echo
echo "################################################################## "
tput setaf 2;echo "Phase 2 : Checking if archiso is installed";tput sgr0
echo "################################################################## "
echo


echo
echo "################################################################## "
tput setaf 2;echo "Phase 3 : Making sure we start with a clean slate";tput sgr0
echo "################################################################## "
echo
echo "De3
[ -d $buildFolder ] && sudo rm -rf $buildFolder


echo
echo "################################################################## "
tput setaf 2;echo "Phase 4 : Moving files to build folder";tput sgr0
echo "################################################################## "
echo
echo "Copying files and folder to build folder"
sudo cp -r ../../DarkOs-Personal $buildFolder

sudo chmod 750 $buildFolder/archiso/airootfs/etc/sudoers.d
sudo chmod 750 $buildFolder/archiso/airootfs/etc/polkit-1/rules.d
sudo chgrp polkitd $buildFolder/archiso/airootfs/etc/polkit-1/rules.d

echo
echo "################################################################## "
tput setaf 2;echo "Phase 5 : Cleaning the cache";tput sgr0
echo "################################################################## "
echo
#yes | sudo pacman -Scc

echo
echo "################################################################## "
tput setaf 2;echo "Phase 5 bis : Linux kernel or linux-lts kernel is chosen on the iso since 11/2019"
echo "https://wiki.archlinux.org/index.php/Kernel";tput sgr0
echo "################################################################## "
echo

echo
echo "################################################################## "
tput setaf 2;echo "Phase 6 : Building the iso";tput sgr0
echo "################################################################## "
echo

cd $buildFolder/archiso/
sudo ./build.sh -v

echo
echo "################################################################## "
tput setaf 2;echo "Phase 7 : Copying the iso to out folder";tput sgr0
echo "################################################################## "
echo
[ -d  $outFolder ] || mkdir $outFolder
cp $buildFolder/archiso/out/darkos* $outFolder

echo
echo "################################################################## "
tput setaf 2;echo "Phase 8 : Making sure we start with a clean slate next time";tput sgr0
echo "################################################################## "
echo
echo "Deleting the build folder if one exists - takes some time"
[ -d $buildFolder ] && sudo rm -rf $buildFolder
