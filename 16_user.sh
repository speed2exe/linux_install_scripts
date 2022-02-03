useradd -m zx
passwd zx
usermod -aG wheel zx
id zx
echo 'enable wheel group: EDITOR=nvim visudo'
echo 'uncomment %wheel ALL=(ALL) ALL'


