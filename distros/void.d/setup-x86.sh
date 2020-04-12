#!/usr/bin/env bash

MOUNTDIR=$1

echo "Installing services"
for service in alsa chronyd dbus dhcpcd elogind iwd
do
	ln -s /etc/sv/${service} "${MOUNTDIR}/etc/runit/runsvdir/default/"
	echo "Installed service ${service}"
done

echo "Copying /etc"
cp -av etc-x86/* "${MOUNTDIR}/etc"
