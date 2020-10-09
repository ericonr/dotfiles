#!/bin/sh

set -eu

GOINSTALL=
SSHFS=
SUBPROJECTS=
MPV=
THEMES=

while [ $# -gt 0 ]; do
	case $1 in
		all) GOINSTALL=1
			 SSHFS=1
			 SUBPROJECTS=1
			 MPV=1
			 THEMES=1
			 ;;
		go) GOINSTALL=1 ;;
		sshfs) SSHFS=1 ;;
		sub) SUBPROJECTS=1 ;;
		mpv) MPV=1;;
		theme) THEMES=1;;
	esac
	shift
done

# create local dirs
mkdir -p "$HOME/.local/bin" "$HOME/.local/share/themes" "$HOME/.config"
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

if [ "$SUBPROJECTS" ]; then
	ln -sf "$PWD/subprojects/git-merge-pr/git-merge-pr" "$HOME/.local/bin/"
	ln -sf "$PWD/subprojects/hugo.el/hugo.el" "$HOME/.config/doom/"
	ln -sf "$PWD/subprojects/fuzzypkg/fuzzypkg" "$HOME/.local/bin"
	ln -sf "$PWD/subprojects/totp.sh/totp.sh" "$HOME/.local/bin"
	make -C subprojects/purr-c install PREFIX=$HOME/.local
	make -C subprojects/get-otp install PREFIX=$HOME/.local
fi

if [ "$MPV" ]; then
	mkdir -p "$HOME/.config/mpv/scripts/"
	ln -sf /usr/lib/mpv-mpris/mpris.so "$HOME/.config/mpv/scripts"
fi

if [ "$THEMES" ]; then
	TMPDIR="$(mktemp -d /tmp/ericonr.XXXXXX)"
	# TODO: host in a better place
	# theme from https://www.pling.com/s/Gnome/p/1231025/
	xbps-fetch -o ${TMPDIR}/cdetheme.tar.gz -s "https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1MjU3Mzc1MTAiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6ImUyYjAyNTFmYzNhZTRjODYzODFhNzczMjYxYzJjMzZiYWU4YTYwYzdhOTAxOTVkMWYzYTUyMmY5MzRiMDFjMWY0ZWUxNjRmYjUwZjZjZjM3Y2NlMmI0Y2QxNWZhNWI1ZmQ5OGY2NjllYTUyYjMzMGZlYWFhNWYwZmExYTdiZjY5IiwidCI6MTU5OTI3OTQ2MCwic3RmcCI6ImVhYjUyMGMyNTJjZjYwZDFlZjhkZTU5ODZjZWM3MThkIiwic3RpcCI6IjE3Ny4xOTQuNjQuMjE1In0.5p8c_SVhRQC7ANItSMK8fqjw3AItLXYFc1Y8TK8UP4c/cdetheme1.3.tar.gz"
	if [ "858d9cfc2962034e577db968667d9ce1ef4e0b76a109dd15ca2c065e3009f499" = "$(xbps-digest ${TMPDIR}/cdetheme.tar.gz)" ]; then
		bsdtar xvf ${TMPDIR}/cdetheme.tar.gz -C $HOME/.local/share/themes
		ln -s cdetheme1.3/cdetheme $HOME/.local/share/themes/cdetheme
		ln -s cdetheme1.3/cdetheme-solaris $HOME/.local/share/themes/cdetheme-solaris
	else
		echo "error when downloading"
	fi
fi
