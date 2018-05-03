
Create Partitions and Filesystems
---------------------------------

```
fdisk # GPT uses last 33 blocks on the disk, so we need to leave them free
gdisk
mkfs.vfat -n boot /dev/sda1
mkfs.ext4 -L nixos /dev/sda2
```

Mount Partitions
----------------

```
mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```

Copy Configs
------------

```
mkdir /mnt/home/user
git clone https://github.com/jorpic/os-config /mnt
```

```
chown -R user\: /home/user
chmod -R o+rw /.git
```
