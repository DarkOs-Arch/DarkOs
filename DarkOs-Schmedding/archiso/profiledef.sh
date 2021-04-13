#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="DarkOs"
iso_label="DarkOs"
iso_publisher="DarkOs <https://bitly.com/DarkOsLinux>"
iso_application="DarkOs Live/Rescue CD"
iso_version="v9.1.1"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
#airootfs_image_tool_options=('-comp' 'xz')
#airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '22')
#airootfs_image_tool_options=('-comp' 'zstd')
file_permissions=(
  ["/root"]="0:0:750"
  ["/etc/sudoers.d"]="0:0:750"
  ["/root/automated_script.sh"]="0:0:755"
  ["/root/.zlogin"]="0:0:755"
  ["/root/.starts"]="0:0:755"
)
