# update mirrorlist
pacman -S reflector rsync
reflector -a 10 -c sg -f 5 --sort rate --save /etc/pacman.d/mirrorlist
