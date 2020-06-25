#!/bin/sh

xbps-reconfigure -fa

useradd -G wheel,video,kvm,xbuilder ericonr
chsh ericonr -s /usr/bin/fish
passwd ericonr
