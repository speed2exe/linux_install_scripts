If the unused partition is physically after the partition with the filesystem, you can resize the partition on the disk, reboot, and then grow the filesystem (if it was a growable filesystem like ext3, ext4, etc).

For example, if you have /dev/sda1 as the filesystem, and /dev/sda2 as the unused partition, check the partitions with fdisk /dev/sda:

`fdisk /dev/sda`
...    
Command (m for help): p
...
  Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *          63     8016434     4008186   83  Linux
/dev/sda2         8016435  1953520064   972751815   83  Linux
You need to make sure that your new sda1 starts in the same location (here, 63) and ends where sda2 starts (here, 8016434). And double-check that where sda1 ends is immediately before where sda2 starts (here, 8016434 is immediately followed by 8016435) just to be sure.

Then delete the unused partition, and the filesystem partition:

Command (m for help): d
Partition number (1-4): 2
...
Command (m for help): d
Partition number (1-4): 1
And finally, recreate the filesystem partition:

Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p
Partition number (1-4, default 1): 1
First sector (63-1953520064, default: 63): 63
...
Last sector, +sectors or +size{K,M,G} (63-1953520064, default 1953520064): 1953520064

Command (m for help): t
Partition number (1-4): 1
Hex code (type L to list codes): 83
And make sure you've got what you're expecting:

Command (m for help): p
...
  Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *          63  1953520064   976760001   83  Linux
Finally, save it:

Command (m for help): w
If any partitions were mounted on the disk, you'll have to reboot first, and then you can grow the filesystem:

`resize2fs /dev/sda1`
