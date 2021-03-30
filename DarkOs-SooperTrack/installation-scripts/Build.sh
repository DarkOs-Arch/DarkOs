#!/bin/bash
#set -e
# DarkOs SooperTrack
# set our parameters
buildFolder="$HOME/DarkOs-build"
outFolder="$HOME/DarkOs-Out"

echo
echo "################################################################## "
tput setaf 2;echo "Phase 3 : Making sure we start with a clean slate";tput sgr0
echo "################################################################## "
echo
echo "Deleting the build folder if one exists - takes some time"
[ -d $buildFolder ] && sudo rm -rf $buildFolder

echo
echo "################################################################## "
tput setaf 2;echo "Phase 4 : Moving files to build folder";tput sgr0
echo "################################################################## "
echo
echo "Copying files and folder to build folder"
sudo cp -r ../../DarkOs-SooperTrack $buildFolder

sudo chmod 750 $buildFolder/archiso/airootfs/etc/sudoers.d
sudo chmod 750 $buildFolder/archiso/airootfs/etc/polkit-1/rules.d
sudo chgrp polkitd $buildFolder/archiso/airootfs/etc/polkit-1/rules.d

# echo
# echo "################################################################## "
# tput setaf 2;echo "Phase 5 : Cleaning the cache";tput sgr0
# echo "################################################################## "
# echo
# #yes | sudo pacman -Scc


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
