#!/bin/bash
bootoptions="mitigations=off nmi_watchdog=0 i915.enable_guc=2 i915.enable_fbc=1 i915.fastboot=1 quiet"



install="
	archlinux-keyring arch-gaming-meta base base-devel blueman bluez-utils bottles bridge-utils brother-hl2030 btop coolercontrol cups discord discord-screenaudio dnsmasq dunst fastfetch feh file-roller firefox gamemode gamescope-nvidia gedit ghostscript git gvfs hyprland hyprshot icaclient inxi iwd jdownloader2 kitty kvantum libva-nvidia-driver libva-mesa-driver linux linux-firmware linux-headers lxappearance network-manager-applet noto-fonts noto-fonts-cjk noto-fonts-emoji os-prober otf-font-awesome pamixer papirus-icon-theme pavucontrol pipewire pipewire-alsa pipewire-jack pipewire-pulse pokemon-colorscripts-git polkit-kde-agent protonplus protontricks rofi-games rofi-wayland sddm sshfs swww teams-for-linux thunar thunar-archive-plugin ttf-font-awesome ttf-iosevka-nerd ttf-jetbrains-mono tumbler udiskie unrar unzip vulkan-tools waybar wget wireplumber wlogout xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-utils yay-git zathura zathura-pdf-mupdf zoxide zsh zsh-autosuggestions zsh-syntax-highlighting zsh-theme-powerlevel10k-git
"
aurinstall="
	https://aur.archlinux.org/aic94xx-firmware.git
	https://aur.archlinux.org/wd719x-firmware.git
	https://aur.archlinux.org/upd72020x-fw.git
	https://aur.archlinux.org/ast-firmware.git
	https://aur.archlinux.org/wireless-regdb-pentest.git
	https://aur.archlinux.org/betaflight-configurator-bin.git
"
gitdownload="
	https://gitlab.com/Suphi/Scripts.git
	https://gitlab.com/Suphi/Configurations.git
"

for item in ${install}; do
		name=${item}
		echo "Installing ${name}"
 #       sudo pacman -Syu ${name}
	done

if [ ! -f /home/jonas/Documents/nvidia-all/PKGBUILD ]; then
    mkdir -p ~/Documents/
    cd ~/Documents/
    git clone https://github.com/Frogging-Family/nvidia-all
fi




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
