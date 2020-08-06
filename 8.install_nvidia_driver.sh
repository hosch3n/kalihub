#!/bin/bash

while true; do
  clear
  echo "
##########################################################
#
#      0. Quit Function
#
#      1. Disable nouveau
#
#      2. Install NVIDIA Driver
#
#
##########################################################
  "
  read -p "Enter selection [0-2] > "
  if [[ "${REPLY}" =~ ^[0-2]$ ]]; then
    if [[ "${REPLY}" == 0 ]]; then
      break
    fi
    if [[ "${REPLY}" == 1 ]]; then
      lspci | grep -E "VGA|3D"
      echo -e "blacklist nouveau\noptions nouveau modeset=0\nalias nouveau off" \
      > /etc/modprobe.d/blacklist-nouveau.conf
      update-grub && update-initramfs -u && reboot
    fi
    if [[ "${REPLY}" == 2 ]]; then
      lsmod | grep -i nouveau
      apt install -y nvidia-driver nvidia-xconfig nvidia-cuda-toolkit
      busid=$(nvidia-xconfig --query-gpu-info | grep 'BusID : ' | cut -d ' ' -f6)
echo -e "Section \"ServerLayout\"
    Identifier \"layout\"
    Screen 0 \"nvidia\"
    Inactive \"intel\"
EndSection

Section \"Device\"
    Identifier \"nvidia\"
    Driver \"nvidia\"
    BusID \"${busid}\"
EndSection

Section \"Screen\"
    Identifier \"nvidia\"
    Device \"nvidia\"
    Option \"AllowEmptyInitialConfiguration\"
EndSection

Section \"Device\"
    Identifier \"intel\"
    Driver \"modesetting\"
EndSection

Section \"Screen\"
    Identifier \"intel\"
    Device \"intel\"
EndSection" > /etc/X11/xorg.conf
  declare -r GDM_CONFIG="[Desktop Entry]
Type=Application
Name=Optimus
Exec=sh -c \"xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto\"
NoDisplay=true
X-GNOME-Autostart-Phase=DisplayServer"
      echo "${GDM_CONFIG}" > /usr/share/gdm/greeter/autostart/optimus.desktop
      echo "${GDM_CONFIG}" > /etc/xdg/autostart/optimus.desktop 
      glxinfo | grep -i "direct rendering"
    fi
  fi
done
