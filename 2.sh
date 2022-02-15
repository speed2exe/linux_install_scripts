#!/bin/sh

echo "--- CHROOT MNT ---"
arch-chroot /mnt

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


echo 'set keyboard layout if different from US to vconsole.conf'
echo 'eg. echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf '


echo 'arch' >> /etc/hostname
echo '127.0.0.1         localhost' >> /etc/hosts
echo '::1               localhost' >> /etc/hosts
echo '127.0.1.1         arch.localdomain' >> /etc/hosts


echo "--- UPDATING MIRRORLIST ---"
pacman -S reflector rsync
reflector -a 10 -c sg -f 5 --sort rate --save /etc/pacman.d/mirrorlist


echo "--- INSTALLING PACKAGES ---"
pacman -Syu grub efibootmgr networkmanager network-manager-applet \
    dialog wpa_supplicant mtools dosfstools base-devel linux-headers \
    bluez bluez-utils xorg xorg-xinit exa fzf bat ripgrep neovim fish \
    neofetch which git trash-cli fortune-mod btop pkgfile \
    gvfs picom sxhkd bspwm pinta maim rofi bsplock \
    dunst dunstify kitty noto-fonts-emoji slock thunar thunar-volum \
    lxappearance arc-gtk-theme breeze xdg-utils xclip \
    os-prober nitrogen gtk4 xbindkeys grub-btrfs doas noto-fonts-cjk \
    --noconfirm


echo "--- SETUP USER ---"
passwd
useradd -m zx
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


echo "--- GETTING GITHUB CONFIGURATION ---"
cd /home/zx/
git clone https://github.com/speed2exe/dotfiles
cd dotfiles
fish load.fish
cd ..


echo "--- STARSHIP INSTALLATION ---"
sh -c "$(curl -fsSL https://starship.rs/install.sh)"


echo "--- PARU SETUP ---"
git clone https://aur.archlinux.org/paru-bin
cd paru-bin/
makepkg -si
paru -S timeshift timeshift-autosnap zramd microsoft-edge-stable-bin
cd ..


echo "--- GRUB INSTALLATION ---"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
echo 'edit /etc/default/grub, uncomment GRUB_DISABLE_OS_PROBER'
echo 'press any key to begin...'
read -s -n 1 input
nvim /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg


echo "--- BTRFS SETUP ---"
echo 'edit the mkinitcpio.conf: nvim /etc/mkinitcpio.conf'
echo 'add btrfs to MODULES'
echo 'press any key to begin...'
read -s -n 1 input
nvim /etc/mkinitcpio.conf
mkinitcpio -p linux


echo "--- ENABLE SERVICES ---"
systemctl enable NetworkManager
systemctl enable zramd
systemctl enable bluetooth
systemctl enable fstrim.timer


echo "BLUETOOTH AUTOENABLE"
echo 'edit the AutoEnable in /etc/bluetooth/main.conf'
echo 'press any key to begin...'
read -s -n 1 input
nvim /etc/bluetooth/main.conf


echo "--- CHANGING DEFAULT SHELL ---"
chsh -s /bin/fish
su zx
chsh -s /bin/fish
