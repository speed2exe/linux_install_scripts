#!/bin/sh

echo "--- UPDATE SYSTEM CLOCK ---"
timedatectl set-ntp true
timedatectl status
echo "Choose Timezone"
timezone=$(find /usr/share/zoneinfo -type f | fzf --reverse --height 30%)
ln -sf $timezone /etc/localtime
hwclock --systohc
date
echo 'Choose Locale:'
chosen=$(cat /etc/locale.gen | fzf --reverse --height 30%)
sed -i "s/${chosen}/${chosen:1}/" /etc/locale.gen
locale-gen
lang=($(cat /etc/locale.gen | sed -e '/^#/d'))
echo "LANG=${lang[0]}" > /etc/locale.conf

# TODO: set tup /etc/vconsole.conf
echo 'set keyboard layout if different from US to vconsole.conf'
echo 'eg. echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf '


echo "--- SETUP HOSTS ---"
echo 'arch' >> /etc/hostname
echo '127.0.0.1         localhost' >> /etc/hosts
echo '::1               localhost' >> /etc/hosts
echo '127.0.1.1         arch.localdomain' >> /etc/hosts


echo "--- INSTALLING PACKAGES ---"
pacman -Syu grub efibootmgr networkmanager network-manager-applet \
    dialog wpa_supplicant mtools dosfstools base-devel linux-headers \
    bluez bluez-utils xorg xorg-xinit exa fzf bat ripgrep neovim fish \
    neofetch which git trash-cli fortune-mod btop pkgfile dnsmasq \
    fd gvfs picom sxhkd bspwm pinta maim rofi words onefetch \
    dunst kitty noto-fonts-emoji slock thunar thunar-volman \
    lxappearance arc-gtk-theme breeze xdg-utils xclip \
    os-prober nitrogen gtk4 xbindkeys grub-btrfs doas noto-fonts-cjk \
    pipewire-alsa pipewire-pulse pipewire-jack pamixer \
    --noconfirm


echo "--- SETUP USER ---"
echo "setting root password..."
passwd
useradd -m zx # TODO: dynamic user
echo "setting zx password..."
passwd zx
usermod -aG wheel zx
id zx
sed -i '/# %wheel ALL=(ALL:ALL) ALL/c\%wheel ALL=(ALL:ALL) ALL' /etc/sudoers
echo 'permit zx as root' > /etc/doas.conf

mv /user.sh /home/zx/.bashrc
su zx
