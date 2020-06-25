#!/bin/sh

cp etc-x86/intel-undervolt.conf "$ROOTDIR/etc"
echo "intel-undervolt apply" >> "$ROOTDIR/etc/rc.local"
