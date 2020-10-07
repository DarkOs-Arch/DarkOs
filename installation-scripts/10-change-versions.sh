#!/bin/bash
# Created For 64bit computers only
# Written By Eric Dubois and Modified By Ybenel(r2dr0dn) Aka pOmS
set -e

echo "Let us change all instances of version number everywhere."

echo "What is the old version? e.g. (v10.0)    (including v and dots)"
read oldversion

echo "To what version do you want upgrade e.g. (v10.1)   (including v and dots)"

read newversion

echo "We will change all old instances i.e. "$oldversion" to this version: "$newversion
echo "Is this correct?  (y/n) "
read response
if [[ "$response" == [yY] ]]; then
    echo "Changing all instances";
    sed -i 's/'$oldversion'/'$newversion'/g' ../archiso/build.sh
    sed -i 's/'$oldversion'/'$newversion'/g' ../archiso/airootfs/etc/os-release
    sed -i 's/'$oldversion'/'$newversion'/g' ../archiso/airootfs/etc/lsb-release
    sed -i 's/'$oldversion'/'$newversion'/g' ../archiso/airootfs/etc/dev-rel
    echo "All done"
	notify-send -u normal "All versions have been updated. Carry on!"

    else
    	echo "################################################################"
        echo "Nothing has been changed.";
		notify-send -u normal "Nothing has changed!"
fi
