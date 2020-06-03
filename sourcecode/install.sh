#!/bin/sh

go install ./lnch
go install ./keyboard_layout_switcher

cd sshfs-map
make install PREFIX=$HOME/.local
