# System configuration

Running `void.sh base_env` installs the stuff that's the bare minimum for my
setup.

Inside `void.d` configuration files for dracut and the kernel tasks in Void can
also be found, as well as a file for setting up all the necessary system
services.

## Configuring chroot installation

Using `xvoidstrap` and `xchroot`, it is easy to install and enter a chroot
installation. Might require installing the `linux` package and generating
initramfs.

- Allow `wheel` group to use `sudo`. Example file in `void.d`.
- Create user in `wheel` (superuser) and `video` (backlight) groups.
- If using `fscrypt` (F2FS and ext4), init it (rules and commands in Arch Wiki).
- Configure Dracut in `/etc/dracut.conf.d/`.

## Configuring any installation

- Configure locales in `/etc/default/libc-locales`.
- Configure AppArmor in `/etc/default/apparmor`.

- Stow stuff and good to go.
