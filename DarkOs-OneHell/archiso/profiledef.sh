#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="DarkOs"
iso_label="DarkOs"
iso_publisher="DarkOs <https://darkos.cf>"
iso_application="DarkOs Live/Rescue CD"
iso_version="v9.11.1"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
#airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
#airootfs_image_tool_options=('-comp' 'xz')
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '15' '-b' '1M')
#airootfs_image_tool_options=('-comp' 'zstd')
file_permissions=(
  ["/root"]="0:0:750"
  ["/etc/sudoers.d"]="0:0:750"
  ["/etc/polkit-1/rules.d"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/usr/local/bin/virtual_machine_check"]="0:0:755"
  ["/usr/local/bin/darkos-cores.sh"]="0:0:755"
  ["/usr/local/bin/darkos-cleanup.sh"]="0:0:755"
  ["/usr/local/bin/xqp"]="0:0:755"
  ["/usr/local/bin/xmenu"]="0:0:755"
  ["/usr/local/bin/setscreen.sh"]="0:0:755"
  ["/usr/local/bin/gradient"]="0:0:755"
)
