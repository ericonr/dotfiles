#!/bin/sh

: ${XBPS_ARCH:=x86_64-musl}
: ${ROOTDIR:=/mnt}
export XBPS_ARCH
export ROOTDIR

BOOTSTRAP=1 ./void.sh ${COLLECTIONS:-current_system}

void.d/system/transfer-install.sh
void.d/system/apparmor.sh
void.d/system/intel.sh
void.d/system/nvidia.sh
void.d/system/service-and-tz.sh
void.d/system/zfs.sh

: ${HOSTNAME:=ericonr}
echo $HOSTNAME > $ROOTDIR/hostname

cp void.d/system/chroot.sh $ROOTDIR/
xchroot $ROOTDIR /chroot.sh
rm $ROOTDIR/chroot.sh
