# linux install scripts

## Pre Install

make sure you have internet connection

`ip -c a`
`iwctl`


## Partition
`lsblk`
`fdisk /dev/the_disk_to_be_partitioned`


### Formatting partitions
`mkfs.vfat /dev/partition_for_boot`
`mkfs.btrfs /dev/main_storage_partition`









