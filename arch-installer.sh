#!/bin/bash
bootoptions="mitigations=off nmi_watchdog=0 i915.enable_guc=2 i915.enable_fbc=1 i915.fastboot=1 quiet"



install="
	archlinux-keyring arch-gaming-meta base base-devel blueman bluez-utils  bridge-utils btop capitaine-cursors cups discord  dnsmasq dunst fastfetch feh firefox gamemode  gedit ghostscript gvfs hyprland inxi iwd kitty kvantum libva-nvidia-driver libva-mesa-driver linux linux-firmware linux-headers nwg-look network-manager-applet noto-fonts noto-fonts-cjk noto-fonts-emoji os-prober otf-font-awesome pamixer papirus-icon-theme pavucontrol polkit-kde-agent rofi-wayland sddm sshfs stow thunar thunar-archive-plugin ttf-font-awesome ttf-iosevka-nerd ttf-jetbrains-mono tumbler udiskie unrar unzip vulkan-tools waybar wget xarchiver xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-utils zathura zathura-pdf-mupdf zoxide zsh zsh-autosuggestions zsh-syntax-highlighting
"
aurinstall="
	bottles brother-hl2030 coolercontrol discord-screenaudio gamescope-nvidia hyprshot icaclient  jdownloader2 pokemon-colorscripts-git protonplus protontricks rofi-games swww teams-for-linux wlogout zsh-theme-powerlevel10k-git
"

gitdownload="
	https://gitlab.com/Suphi/Scripts.git
	https://gitlab.com/Suphi/Configurations.git
"
services="
bluetooth coolercontrold cups NetworkManager polkit rtkit-daemon sddm
"

for item in ${install}; do
    name=${item}
    echo "\nInstalling ${name}"
    sudo pacman -Syu ${name} --noconfirm
done

if [ ! -f ~/Documents/yay/PKGBUILD ]; then
    mkdir -p ~/Documents/
    cd ~/Documents/
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi

if [ ! -f ~/Documents/nvidia-all/PKGBUILD ]; then
    cd ~/Documents/
    git clone https://github.com/Frogging-Family/nvidia-all
    cd nvidia-all/
    makepkg -si
fi

for item in ${services}; do
    name=${item}
    echo "\nActivating ${name}"
    sudo systemctl enable ${name}
done


fc-cache -f -v

#Nvidia Setup
echo -e "\033[0;32m[BOOTLOADER]\033[0m nvidia detected, adding nvidia_drm.modeset=1 to boot option..."
gcld=$(grep "^GRUB_CMDLINE_LINUX_DEFAULT=" "/etc/default/grub" | cut -d'"' -f2 | sed 's/\b nvidia_drm.modeset=.\b//g')
sudo sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/c\GRUB_CMDLINE_LINUX_DEFAULT=\"${gcld} nvidia_drm.modeset=1\"" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

#Multilib
sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf

sudo mkdir /etc/pacman.d/hooks
sudo cp extras/nvidia.hook /etc/pacman.d/hooks/

#for item in ${aurinstall}; do
#		name=$(basename ${item} .git)
#		echo "Installing ${name}"
#		cd /tmp
#		sudo -u ${user} git clone ${item} 2> /dev/null
#		cd ${name}
#		sudo -u ${user} makepkg -sirc --noconfirm > /dev/null 2> /dev/null
#		cd /tmp
#		rm -rf ${name}
#	done
