
Create Partitions and Filesystems
---------------------------------

```
fdisk # create GPT partition table
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
cd /mnt
git init
git remote add origin https://github.com/jorpic/os-config
git pull origin master

# Allow everyone to `git commit` without `sudo`
chmod -R o+rw /.git
```

Install and Reboot
------------------

```
nixos-install
reboot
```
