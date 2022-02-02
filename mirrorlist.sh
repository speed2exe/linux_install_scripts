# update mirrorlist
pacman -S reflector
reflector -a 10 -c sg -f 5 --sort rate --save /etc/pacmand.d/mirrorlist
