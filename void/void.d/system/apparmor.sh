#!/bin/sh

cp etc-x86/default/apparmor $ROOTDIR/etc/default/
cp etc-x86/apparmor.d/local/* $ROOTDIR/etc/apparmor.d/local/
