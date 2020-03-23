#!/usr/bin/env bash

#               _                           
#    ___  _ __ (_)  ___   ___   _ __   _ __ 
#   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
#  |  __/| |   | || (__ | (_) || | | || |   
#   \___||_|   |_| \___| \___/ |_| |_||_|   
#                                           

# install script for Void based systems

function print_help () {
	echo Look inside for available stuff
}

function base () {
	xbps-install \
		base-system \
		binutils \
		cryptsetup \
		chrony \
		elogind \
		fscrypt \
		gummiboot \
		sbsigntool \
		udisks2 \
		vsv
}

function refind () {
	xbps-install refind
}

function fonts () {
	xbps-install \
		font-awesome5 \
		font-fira-ttf \
		font-ibm-plex-ttf \
		liberation-fonts-ttf \
		noto-fonts-ttf \
		noto-fonts-emoji \
		ttf-bitstream-vera
}

function themes () {
	xbps-install \
		breeze \
		breeze-gtk \
		breeze-snow-cursor-theme \
		papirus-icon-theme
}

function wm () {
	xbps-install \
		Waybar \
		alacritty \
		brightnessctl \
		fzf \
		grim \
		jq \
		mako \
		redshift \
		slurp \
		sway \
		swayidle \
		swaylock \
		wl-clipboard \
		wofi

	fonts
	themes
}

function audio () {
	xbps-install \
		alsa-utils \
		playerctl \
		pulseaudio \
		pavucontrol
}

function media () {
	xbps-install \
		elisa \
		mpv \
		spotifyd \
		spotify-tui
}

function term () {
	xbps-install \
		bat \
		bmon \
		fd \
		fish-shell \
		htop \
		mdcat \
		neovim \
		python3 \
		ripgrep \
		starship \
		stow \
		tmux
}

function kicad () {
	xbps-install \
		kicad \
		kicad-footprints \
		kicad-library \
		kicad-packages3D \
		kicad-symbols \
		kicad-templates
}

function dev () {
	xbps-install \
		clang \
		cmake \
		make \
		meson \
		ninja \
		git \
		go
}

function emacs () {
	xbps-install \
		emacs-gtk2 \
		hunspell \
		hunspell-en_US \
		hunspell-pt_BR
}

function intel () {
	xbps-install \
		intel-gpu-tools \
		iwd \
		libva-intel-driver \
		intel-media-driver \
		mesa-intel-dri
}

function qt5 () {
	xbps-install qt5-wayland qt5ct
}

function kde () {
	qt5
	xbps-install qutebrowser konversation pdf.js
}

function mozilla () {
	xbps-install firefox thunderbird
}

function libreoffice () {
	xbps-install \
		libreoffice \
		libreoffice-i18n-en-US \
		libreoffice-i18n-pt-BR
}

function pdf () {
	xbps-install zathura zathura-pdf-poppler
}

function flatpak () {
	sudo xbps-install \
		flatpak \
		xdg-desktop-portal \
		xdg-desktop-portal-gtk \
		xdg-user-dirs \
		xdg-user-dirs-gtk \
		xdg-utils
}

function embedded () {
	sudo xbps-install \
		arduino-cli \
		cross-arm-none-eabi \
		cross-arm-none-eabi-gdb \
		openocd
}

# Run function from script:
# https://stackoverflow.com/questions/8818119/how-can-i-run-a-function-from-a-script-in-command-line
# Check if the function exists (bash specific)
if declare -f "$1" > /dev/null
then
	xbps-install -S
	# call arguments verbatim
	"$@"
else
	# Show a helpful error
	echo "'$1' is not a known function name" >&2
	print_help
	exit 1
fi

