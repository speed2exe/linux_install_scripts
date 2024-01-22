#! /usr/bin/env bash
#
# curl https://raw.githubusercontent.com/speed2exe/linux_install_scripts/main/nix.sh | sudo bash

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
