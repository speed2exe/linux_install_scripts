# linux install scripts
- follow steps below

## On EFI boot
- make sure you have internet connection
    - check: `ip -c a`
    - for wireless connection: `iwctl`

## Partition
- check: `lsblk`
- require 2 Partition
    - EFI System Partition: 350M
    - Linux File System: rest of disk space
- action: `cfdisk /dev/the_disk_to_be_partitioned`

## Run EFI Boot Script
- supply 2 arg
    - 1: EFI System Partition
    - 2: Linux File System
    - e.g. `./1 /dev/sda1 /dev/sda2`


