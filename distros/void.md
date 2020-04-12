# Facilitating the installation of Void Linux

Running `void.sh install_most` installs the stuff that's the bare minimum for my setup.

Inside `void.d` configuration files for dracut and the kernel tasks in Void can also be found, as well as a file for setting up all the necessary system services.

## Installation steps

### Partitioning and creating filesystems

Partitioning was manual. A UEFI setup can have only an ESP partition and the main user one. Partitioning can be done with either `gdisk` (more CLI-y) or `cfdisk` (more TUI-y). The ESP partition should be formatted as FAT32, and the user one should be made into a LUKS2 volume via

```shell
cryptsetup --type luks2 luksFormat /path/to/device
```

This will ask you for the desired password and encryption scheme.

To open the LUKS volume, run

```shell
cryptsetup open /path/to/device mappername
```

This will create a device in `/dev/mapper` named `mappername`. This device can then de formatted with your filesystem of choice. I tend to go either with Brtfs, ext4 or F2FS. The last two support per folder encryption if you want to have another layer of protection (can be specially relevant in a multi-user setup). Formatting is done by

```shell
mkfs.filesystem /path/to/device [-O encrypt]
```

The filesystem should now be ready to be used!

### Installing the root filesystem

The current installation setup was made by downloading a ROOTFS image from the [Void Linux download page](https://a-hel-fi.m.voidlinux.org/live/current/) and untarring it into the root of the desired filesystem.

```shell
tar xvf void-x86_64-ROOTFS-20191109.tar.xz
```

TODO: chroot into, DNS, install basic stuff (iwd and neovim, mostly), install Linux, create initramfs, reboot, log into root, allow wheel to access stuff, create user with certain groups, init fscrypt (copy rules from Arch Wiki), git clone package, stow stuff, run startsway.
