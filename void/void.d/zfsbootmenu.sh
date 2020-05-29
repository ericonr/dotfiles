#!/bin/sh

zfs set org.zfsbootmenu:commandline="$(cat etc-x86/zfsbootmenu/commandline)" zroot/ROOT
