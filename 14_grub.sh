grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
pacman -Syu os-prober
echo 'edit /etc/default/grub, uncomment GRUB_DISABLE_OS_PROBER'
echo 're run config do: grub-mkconfig -o /boot/grub/grub.cfg' 
