#!/bin/bash

# User = liveuser
# Password = empty
count=0

function layout() {
    count=$[count+1]
    echo
    echo "##########################################################"
    tput setaf 1;echo $count. " Function " $1 "has been installed";tput sgr0
    echo "##########################################################"
    echo
}

function deleteXfceWallpapers() {
    rm -rf /usr/share/backgrounds/xfce
}

function umaskFunc() {
    set -e -u
    umask 022
}

function localeGenFunc() {
    sed -i 's/^#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
    export LANGUAGE=en_US.UTF-8
    export LANG=en_US.UTF-8
    #export LC_ALL=en_US.UTF-8
    locale-gen
}

function setTimeZoneAndClockFunc() {
    # Timezone
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime
    # Set clock to UTC
    hwclock --systohc --utc
}

function editOrCreateConfigFilesFunc () {

    # Locale
    echo "LANG=en_US.UTF-8" > /etc/locale.conf

    sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
    sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
    sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf
}

function configRootUserFunc() {
    usermod -s /usr/bin/bash root
    cp -aT /etc/skel/ /root/
    chmod 750 /root
}

function createLiveUserFunc () {
	# add liveuser
	useradd -m liveuser -u 500 -g users -G "adm,audio,floppy,log,network,wheel,rfkill,scanner,storage,optical,power" -s /bin/bash
	chown -R liveuser:users /home/liveuser
	passwd -d liveuser
	# enable autologin
	groupadd -r autologin
	gpasswd -a liveuser autologin
	groupadd -r nopasswdlogin
	gpasswd -a liveuser nopasswdlogin
	echo "The account liveuser with no password has been created"
}

function setDefaultsFunc() {
    export _EDITOR=nvim
    echo "EDITOR=${_EDITOR}" >> /etc/environment
    echo "EDITOR=${_EDITOR}" >> /etc/profile
}

function fixHavegedFunc(){
    systemctl enable haveged
}

function fixPermissionsFunc() {
    chmod 750 /etc/sudoers.d
    chmod 750 /etc/polkit-1/rules.d
    chgrp polkitd /etc/polkit-1/rules.d
}

function enableServicesFunc() {
    systemctl enable vmtoolsd.service
	systemctl enable lightdm.service
	systemctl set-default graphical.target
	systemctl enable NetworkManager.service
	systemctl enable virtual-machine-check.service
	#systemctl enable update-mirror.service
  #systemctl enable org.cups.cupsd.service
  systemctl enable bluetooth.service
  systemctl enable ntpd.service
  #systemctl enable smb.service
  #systemctl enable nmb.service
  #systemctl enable winbind.service
  systemctl enable avahi-daemon.service
  systemctl enable avahi-daemon.socket
  #systemctl enable tlp.service
  #systemctl enable tlp-sleep.service
  #systemctl enable vnstat.service
}

function fixWifiFunc() {
    #https://wiki.archlinux.org/index.php/NetworkManager#Configuring_MAC_Address_Randomization
    su -c 'echo "" >> /etc/NetworkManager/NetworkManager.conf'
    su -c 'echo "[device]" >> /etc/NetworkManager/NetworkManager.conf'
    su -c 'echo "wifi.scan-rand-mac-address=no" >> /etc/NetworkManager/NetworkManager.conf'
}

function fixHibernateFunc() {
    sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
    sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
    sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf
}

function initkeysFunc() {
    pacman-key --init
    pacman-key --populate archlinux
    pacman-key --populate darkos
}

function create_autorun() {
    if [ -d /home/liveuser/.config/ ]; then
        if [ ! -d /home/liveuser/.config/autostart/ ]; then
            mkdir -p  /home/liveuser/.config/autostart/
        fi
    fi
    cp /etc/xdg/autostart/calamares-darkos.desktop /home/liveuser/.config/autostart/
    echo "#!/usr/bin/env bash" > /home/liveuser/.config/autostart/ustart.sh
    echo "dex ~/.config/autostart/calamares-darkos.desktop" >> /home/liveuser/.config/autostart/ustart.sh
    echo "if [ -f ~/.config/autostart/ustart.sh ]; then" >> /home/liveuser/.config/autostart/ustart.sh
    echo "    rm -f ~/.config/autostart/ustart.sh" >> /home/liveuser/.config/autostart/ustart.sh
    echo "fi" >> /home/liveuser/.config/autostart/ustart.sh
    chmod +x /home/liveuser/.config/autostart/ustart.sh
    chmod +x /usr/local/bin/xqp /usr/local/bin/setscreen.sh /usr/local/bin/config_userfix.sh /usr/local/bin/xmenu
}


function sed_stuff(){
    echo "Reched This Part"
    sed1="Exec=herbstluftwm"
    sed_r1="Exec=herbstluftwm -l"
    sed -i "s/$sed1/$sed_r1/g" /usr/share/xsessions/herbstluftwm.desktop
    cat /usr/share/xsessions/herbstluftwm.desktop
    echo "Finished"
    cat /etc/pacman.conf
}

# function checkdarkos(){
#     echo "Reached DarkOs"
#     check=$(grep "DarkOs-Repo" /etc/pacman.conf)
#     cat $check
#     if [ -z $check ]; then
#         echo "[DarkOs-Repo]" >> /etc/pacman.conf
#         echo "SigLevel = Required DatabaseOptional" >> /etc/pacman.conf
#         echo "Include = /etc/pacman.d/darkos-mirrorlist" >> /etc/pacman.conf
#     fi
#     cat /etc/pacman.conf
#     echo "Done With CheckDarKos"
# }

function getNewMirrorCleanAndUpgrade() {
    reflector --threads 25 -p "http,https" -l 50 -f 50 --number 50 --sort rate --save /etc/pacman.d/mirrorlist
    pacman -Sc --noconfirm
    #pacman -Syyu --noconfirm
}

deleteXfceWallpapers
layout deleteXfceWallpapers
umaskFunc
layout umaskFunc
localeGenFunc
layout localeGenFunc
setTimeZoneAndClockFunc
layout setTimeZoneAndClockFunc
editOrCreateConfigFilesFunc
layout editOrCreateConfigFilesFunc
configRootUserFunc
layout configRootUserFunc
createLiveUserFunc
layout createLiveUserFunc
setDefaultsFunc
layout setDefaultsFunc
fixHavegedFunc
layout fixHavegedFunc
fixPermissionsFunc
layout fixPermissionsFunc
enableServicesFunc
layout enableServicesFunc
fixWifiFunc
layout fixWifiFunc
fixHibernateFunc
layout fixHibernateFunc
initkeysFunc
layout initkeysFunc
create_autorun
layout create_autorun
sed_stuff
layout sed_stuff
# checkdarkos
# layout checkdarkos
getNewMirrorCleanAndUpgrade
layout getNewMirrorCleanAndUpgrade
