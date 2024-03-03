#! /usr/bin/env bash
#
# ...after setting up network and disk
# curl https://raw.githubusercontent.com/speed2exe/linux_install_scripts/main/nix.sh | bash -s -- /dev/<boot_partition> /dev/<root_partition>

boot=$1
volume=$2

if test -z "$boot"
then
    echo "first arg should have boot partition"
    exit 1
fi

if test -z "$volume"
then
    echo "second arg should have root partition"
    exit 1
fi

mkfs.vfat $boot
mkfs.btrfs -f $volume

mount $volume /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
umount /mnt

mount -o compress=zstd,subvol=@ $volume /mnt
mkdir -p /mnt/{boot,home,nix}
mount -o compress=zstd,subvol=@home $volume /mnt/home
mount -o compress=zstd,subvol=@nix $volume /mnt/nix
mount $boot /mnt/boot

nixos-generate-config --root /mnt
curl https://raw.githubusercontent.com/speed2exe/linux_install_scripts/main/configuration.nix > /mnt/etc/nixos/configuration.nix
nixos-install --no-root-password

# commands have issues running automatically after previous command
nixos-enter --command 'passwd zack2827'
nixos-enter --command 'su zack2827 --command "curl https://raw.githubusercontent.com/speed2exe/dotfiles/main/setup.sh | bash"'

