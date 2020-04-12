#!/usr/bin/env bash

MOUNTDIR=$1

FOLDER="${MOUNTDIR}/etc/certs"
mkdir -p $FOLDER
cp eduroam-unicamp.pem $FOLDER

FOLDER="${MOUNTDIR}/var/lib/iwd"
mkdir -p $FOLDER
cp eduroam.8021x $FOLDER
