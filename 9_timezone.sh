# update system clock
timedatectl set-ntp true
timedatectl status
echo 'timedatectl list-timezones to show all time zone'
ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime
hwclock --systohc
