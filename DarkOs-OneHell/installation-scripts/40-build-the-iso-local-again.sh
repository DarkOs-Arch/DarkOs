#!/bin/bash
#set -e
# Author	:	Erik Dubois
# Modified By: ybenel
# set our parameters
buildFolder="/home/ybenel/Builds/Personal/Image"
outFolder="/home/ybenel/Builds/Personal/Iso"

echo
echo "################################################################## "
tput setaf 2;echo "Phase 1 : get the latest bashrc from github";tput sgr0
echo "################################################################## "
echo
echo "Removing old files/folders from /etc/skel"
#rm -rf ../archiso/airootfs/etc/skel/.* 2> /dev/null
echo "getting .bashrc from dotfiles"
# Adding bashrc later
#wget https://raw.githubusercontent.com/m1ndo/dotfiles/master/.bashrc -O ../archiso/airootfs/etc/skel/.bashrc
echo ".bashrc copied to /etc/skel"

echo
echo "################################################################## "
tput setaf 2;echo "Phase 2 : Making sure we start with a clean slate";tput sgr0
echo "################################################################## "
echo
echo "Deleting the build folder if one exists - takes some time"
[ -d $buildFolder ] && sudo rm -rf $buildFolder


echo
echo "################################################################## "
tput setaf 2;echo "Phase 3 : Moving files to build folder";tput sgr0
echo "################################################################## "
echo
echo "Copying files and folder to build folder"
sudo cp -r ../../DarkOs-Personal $buildFolder

sudo chmod 750 $buildFolder/archiso/airootfs/etc/sudoers.d
sudo chmod 750 $buildFolder/archiso/airootfs/etc/polkit-1/rules.d
sudo chgrp polkitd $buildFolder/archiso/airootfs/etc/polkit-1/rules.d

echo
echo "################################################################## "
tput setaf 2;echo "Phase 4 : Building the iso";tput sgr0
echo "################################################################## "
echo

cd $buildFolder/archiso/
echo "Running Build Script"
sudo ./build.sh -v
