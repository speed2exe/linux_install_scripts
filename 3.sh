# TODO: wallpaper

echo "--- GETTING GITHUB CONFIGURATION ---"
git clone https://github.com/speed2exe/dotfiles
cd dotfiles
fish load.fish
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cd ..


echo "--- STARSHIP INSTALLATION ---"
sh -c "$(curl -fsSL https://starship.rs/install.sh)"


echo "--- PARU SETUP ---"
git clone https://aur.archlinux.org/paru-bin
cd paru-bin/
makepkg -si
sudo paru -S timeshift timeshift-autosnap zramd microsoft-edge-stable-bin
cd ..


echo "--- GRUB INSTALLATION ---"
sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg
echo 'edit /etc/default/grub, uncomment GRUB_DISABLE_OS_PROBER'
echo 'press any key to begin...'
read -s -n 1 input
sudo nvim /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg


echo "--- BTRFS SETUP ---"
echo 'edit the mkinitcpio.conf: nvim /etc/mkinitcpio.conf'
echo 'add btrfs to MODULES'
echo 'press any key to begin...'
read -s -n 1 input
sudo nvim /etc/mkinitcpio.conf
sudo mkinitcpio -p linux


echo "--- ENABLE SERVICES ---"
sudo systemctl enable NetworkManager
sudo systemctl enable zramd
sudo systemctl enable bluetooth
sudo systemctl enable fstrim.timer


echo "BLUETOOTH AUTOENABLE"
echo 'edit the AutoEnable in /etc/bluetooth/main.conf'
echo 'press any key to begin...'
read -s -n 1 input
sudo nvim /etc/bluetooth/main.conf


echo "--- CHANGING DEFAULT SHELL ---"
chsh -s /usr/bin/fish
