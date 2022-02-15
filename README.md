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

## Run 1.sh
- supply 2 arg
    - 1: EFI System
    - 2: Linux filesystem
    - e.g. `./1 /dev/sda1 /dev/sda2`

## Run 2.sh
