#!/usr/bin/env bash

MOUNTDIR=$1

echo "Installing services"
for service in alsa bluetoothd boltd chronyd dbus dhcpcd elogind iwd popcorn
do
	if [ -r /etc/sv/${service} ] ; then
		ln -s /etc/sv/${service} "${MOUNTDIR}/etc/runit/runsvdir/default/"
		echo "Installed service ${service}"
	else
		echo "Service ${service} not found"
	fi
done

echo "Setting timezone"
ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
