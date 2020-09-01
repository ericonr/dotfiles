#!/bin/sh

set -eu

GOINSTALL=
SSHFS=
CBC=
SUBPROJECTS=
MPV=

while [ $# -gt 0 ]; do
	case $1 in
		all) GOINSTALL=1
			 SSHFS=1
			 SUBPROJECTS=1
			 MPV=1
			 CBC=1
			 ;;
		go) GOINSTALL=1 ;;
		sshfs) SSHFS=1 ;;
		cbc) CBC=1 ;;
		sub) SUBPROJECTS=1 ;;
		mpv) MPV=1;;
	esac
	shift
done

# create local dirs
mkdir -p "$HOME/.local/bin" "$HOME/.local/share" "$HOME/.config"
export PREFIX="$HOME/.local"

if [ "$GOINSTALL" ]; then
	GOTMPDIR="$(go env GOTMPDIR)"
	[ "$GOTMPDIR" ] && mkdir -p "$GOTMPDIR"
	go install ./lnch
	go install ./keyboard_layout_switcher
fi

if [ "$SSHFS" ]; then
	make install -C sshfs-map
fi

if [ "$CBC" ]; then
	make install -C cbc-file
fi

if [ "$SUBPROJECTS" ]; then
	ln -sf "$PWD/subprojects/git-merge-pr/git-merge-pr" "$HOME/.local/bin/"
	ln -sf "$PWD/subprojects/hugo.el/hugo.el" "$HOME/.config/doom/"
	ln -sf "$PWD/subprojects/fuzzypkg/fuzzypkg" "$HOME/.local/bin"
	ln -sf "$PWD/subprojects/totp.sh/totp.sh" "$HOME/.local/bin"
fi

if [ "$MPV" ]; then
	mkdir -p "$HOME/.config/mpv/scripts/"
	ln -sf /usr/lib/mpv-mpris/mpris.so "$HOME/.config/mpv/scripts"
fi
