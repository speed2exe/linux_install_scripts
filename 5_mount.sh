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
