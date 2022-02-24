#!/bin/sh

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
mkfs.btrfs $volume

mount $volume /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var

umount /mnt

mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@ $volume /mnt
mkdir -p /mnt/{boot/efi,home,var}
mount $boot /mnt/boot/efi
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@/home $volume /mnt/home
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@/var $volume /mnt/var

lsblk

reflector -a 10 -c sg -f 5 --sort rate --save /etc/pacman.d/mirrorlist
sed -i '/#ParallelDownloads = 5/c\ParallelDownloads = 5' /etc/pacman.conf

pacstrap /mnt/ base linux linux-firmware git neovim btrfs-progs fzf rsync reflector sudo
cp /etc/pacmand.d/mirrorlist /mnt/etc/pacmand.d/mirrorlist
cp /etc/pacman.conf /mnt/etc/pacman.conf

genfstab -U /mnt >> /mnt/etc/fstab

cp 2.sh /mnt/root/.bashrc
cp 3.sh /mnt/3.sh
arch-chroot /mnt
rm /mnt/root/.bashrc
