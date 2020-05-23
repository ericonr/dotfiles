#!/bin/sh

MOUNTDIR=$1

cp etc-x86/intel-undervolt.conf "$MOUNTDIR/etc"

echo "intel-undervolt apply" >> "$MOUNTDIR/etc/rc.local"
