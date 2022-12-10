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
