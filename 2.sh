#!/bin/sh

echo "--- UPDATE SYSTEM CLOCK ---"
timedatectl set-ntp true
timedatectl status
echo "Choose Timezone"
timezone=$(find /usr/share/zoneinfo -type f | fzf --reverse --height 30%)
ln -sf $timezone /etc/localtime
hwclock --systohc
date
echo 'uncomment a line in /etc/locale.gen to set locale'
echo 'press any key to begin...'
read -s -n 1 input
nvim /etc/locale.gen
locale-gen
cat /etc/locale.gen | sed -e '/^#/d' > /etc/locale.conf

# TODO: set tup /etc/vconsole.conf
echo 'set keyboard layout if different from US to vconsole.conf'
echo 'eg. echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf '

echo 'arch' >> /etc/hostname
echo '127.0.0.1         localhost' >> /etc/hosts
echo '::1               localhost' >> /etc/hosts
echo '127.0.1.1         arch.localdomain' >> /etc/hosts


echo "--- UPDATING MIRRORLIST ---"
reflector -a 10 -c sg -f 5 --sort rate --save /etc/pacman.d/mirrorlist


echo "--- INSTALLING PACKAGES ---"
pacman -Syu grub efibootmgr networkmanager network-manager-applet \
    dialog wpa_supplicant mtools dosfstools base-devel linux-headers \
    bluez bluez-utils xorg xorg-xinit exa fzf bat ripgrep neovim fish \
    neofetch which git trash-cli fortune-mod btop pkgfile \
    gvfs picom sxhkd bspwm pinta maim rofi \
    dunst kitty noto-fonts-emoji slock thunar thunar-volman \
    lxappearance arc-gtk-theme breeze xdg-utils xclip \
    os-prober nitrogen gtk4 xbindkeys grub-btrfs doas noto-fonts-cjk \


echo "--- SETUP USER ---"
echo "setting root password..."
passwd
useradd -m zx
echo "setting zx password..."
passwd zx
usermod -aG wheel zx
id zx
echo 'enable wheel group: EDITOR=nvim visudo'
echo 'uncomment %wheel ALL=(ALL) ALL'
echo 'press any key to begin...'
read -s -n 1 input
EDITOR=nvim visudo
echo 'permit zx as root' > /etc/doas.conf
rm -rf /root/
ln -s /home/zx /root
