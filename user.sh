cd ~

echo "--- GETTING GITHUB CONFIGURATION ---"
git clone https://github.com/speed2exe/dotfiles
cd dotfiles
fish load.fish
cd ~


echo "--- GETTING EXTRAS CONFIGURATION ---"
git clone https://github.com/speed2exe/linux_install_scripts
cd linux_install_scripts/extras
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo cp autologin/autologin.conf /etc/systemd/system/getty@tty1.service.d/autologin.conf
cd fonts
fish fonts.fish
cd ~


echo "--- STARSHIP INSTALLATION ---"
sh -c "$(curl -fsSL https://starship.rs/install.sh)"


echo "--- PARU SETUP ---"
git clone https://aur.archlinux.org/paru-bin
cd paru-bin/
makepkg -si
sleep 5
paru -Syu timeshift timeshift-autosnap zramd microsoft-edge-stable-bin \
    polybar backlight_control nvim-packer-git stderred-git \
    --noconfirm
cd ~


echo "--- GRUB INSTALLATION ---"
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo sed -i '/#GRUB_DISABLE_OS_PROBER=false/c\GRUB_DISABLE_OS_PROBER=false' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB


echo "--- BTRFS SETUP ---"
sudo sed -i '/MODULES=()/c\MODULES=(btrfs)' /etc/mkinitcpio.conf
sudo mkinitcpio -p linux


echo "--- ENABLE SERVICES ---"
sudo systemctl enable NetworkManager
sudo systemctl enable zramd
sudo systemctl enable bluetooth
sudo systemctl enable fstrim.timer


echo "--- BLUETOOTH AUTOENABLE ---"
sudo sed -i '/#AutoEnable=false/c\AutoEnable=true' /etc/bluetooth/main.conf


echo "--- CHANGING DEFAULT OWNER ---"
sudo chown -R zx ~


rm ~/.bashrc
