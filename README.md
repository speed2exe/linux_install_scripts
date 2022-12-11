# linux install scripts
- follow steps below

## On EFI boot
- make sure you have internet connection
  - check: `ip -c a`
  - for wireless connection: `iwctl`

## Partition
- check: `lsblk`
- require 2 Partition
  - EFI System: 350M
  - Linux filesystem: rest of disk space
- action: `cfdisk /dev/the_disk_to_be_partitioned`

## Run main.sh
- supply 2 arg
  - 1: EFI System Partition
  - 2: Linux Filesystem Partition
  - e.g. `./main.sh /dev/sda1 /dev/sda2`

## Common problems
- Black screen after boot
  - at the grub menu, press `e`
  - find the line with starting word `linux`
  - add `nomodeset` to the end that line
  - after installation, add `nomodeset` to `GRUB_CMDLINE_LINUX_DEFAULT` and rebuild grub
- nvidia graphics card display issue
  - do `sudo pacman -Syu nvidia` after installation
- USB ports not working during grub selection
  - go to BIOS, disable `Fast Boot`
