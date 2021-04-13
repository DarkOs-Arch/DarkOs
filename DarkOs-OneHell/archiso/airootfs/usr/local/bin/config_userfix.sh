#!/usr/bin/env bash
username=$1
userch="liveuser"
if [ -z $username ]; then
	echo "No Username was defined!"
	echo "run changeuser.sh <YOUR_USERNAME>"
	echo "Script to remove liveuser tags from config files"
	exit 1;
fi
DIR="/etc/skel"
declare -a Files=(".config/awesome/rc.lua" ".config/ncmpcpp/config" ".config/rofi/config" ".config/sxhkd/sxhkdrc" ".config/xmobar/xmobarrc" ".dmenu/dmenu-scrot.sh" ".xmonad/xmonad.hs" "xmenuu")
for val in ${Files[@]}; do
	echo '--------------------------------------------'
	echo "Changing File"
	echo $DIR/$val
	echo '--------------------------------------------'
	sed -i "s/$userch/$username/g" $DIR/$val
	echo '--------------------------------------------'
	echo "Changes Are Done"
	echo '--------------------------------------------'
done
