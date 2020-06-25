#!/bin/sh

: ${ROOTDIR:=/mnt}

copy() {
	[ -e /$1 ] && cp -a /$1 $ROOTDIR/$1
}

copy etc/hostid
copy etc/zfsbootmenu
copy etc/zfs/zroot.key
copy etc/fstab
copy usr/share/secureboot
