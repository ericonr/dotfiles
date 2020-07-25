#!/bin/sh

set -e

rm -f enter-chroot
make enter-chroot

install -m4755 enter-chroot /usr/local/bin/
