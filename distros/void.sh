#!/usr/bin/env bash

#               _                           
#    ___  _ __ (_)  ___   ___   _ __   _ __ 
#   / _ \| '__|| | / __| / _ \ | '_ \ | '__|
#  |  __/| |   | || (__ | (_) || | | || |   
#   \___||_|   |_| \___| \___/ |_| |_||_|   
#                                           

# install script for Void based systems

function base () {
	xbps-install \
		chrony \
		elogind \
		fscrypt \
		iwd \
		udisks2 \
		vsv
}
function base_desc () {
	echo "Install base system utilities, with encryption and UEFI support."
}

function luks () {
	xbps_install cryptsetup
}
function luks_desc () {
	echo "Install support for LUKS."
}

function uefi_bundle () {
	xbps-install \
		binutils \
		gummiboot \
		sbsigntool
}
function uefi_bundle_desc () {
	echo "Install tools for creating UEFI bundles."
}

function refind () {
	xbps-install refind
}
function refind_desc () {
	echo "Install rEFInd boot manager. Necessary when it's the only system on a device."
}

function zfs () {
	xbps-install zfs zfsbootmenu
}
function zfs_desc () {
	echo "Install support for ZFS."
}

function security () {
	xbps-install apparmor
}
function security_desc () {
	echo "Install security related packages."
}

function popcorn () {
	xbps-install PopCorn
}
function popcorn_desc () {
	echo "Install PopCorn usage statistics."
}

function term () {
	xbps-install \
		bat \
		bmon \
		curl \
		fd \
		fish-shell \
		gnupg2 \
		htop \
		mdcat \
		neovim \
		python3 \
		p7zip \
		ranger \
		ripgrep \
		starship \
		stow \
		tmux \
		xtools \
		xz \
		zstd \
		zip \
		bsdunzip \
		bsdtar
}
function term_desc () {
	echo "Install basic terminal utilities."
}

function intel () {
	xbps-install \
		intel-gpu-tools \
		libva-intel-driver \
		intel-media-driver \
		mesa-intel-dri
}
function intel_desc () {
	echo "Install packages for media decode and GPU stuff in Intel-land."
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
function fonts_desc () {
	echo "Basic fonts necessary for browsing the web and normal GUIs."
}

function themes () {
	xbps-install \
		breeze \
		breeze-gtk \
		breeze-snow-cursor-theme \
		papirus-icon-theme
}
function themes_desc () {
	echo "Color and mouse themes for a good color setup."
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
function wm_desc () {
	echo "Install the SwayWM and supporting packages."
}

function audio () {
	xbps-install \
		alsa-utils \
		playerctl \
		pulseaudio \
		pavucontrol
}
function audio_desc () {
	echo "Install PulseAudio and alsa."
}

function media () {
	audio

	xbps-install \
		bluez \
		elisa \
		mpv \
		mpv-mpris \
		spotifyd \
		spotify-tui \
		youtube-dl
}
function media_desc () {
	echo "Install the Elisa player, mpv, and spotify CLI programs."
}

function dev () {
	xbps-install \
		clang \
		cmake \
		make \
		meson \
		ninja \
		git \
		go \
		rustup \
		tokei
}
function dev_desc () {
	echo "Install the CLang compiler, some build systems, the Go compiler, and rustup."
}

function emacs () {
	xbps-install \
		emacs-gtk2 \
		hunspell \
		hunspell-en_US \
		hunspell-pt_BR
}
function emacs_desc () {
	echo "(deprecated) Install the GUI version of Emacs."
}

function qt5 () {
	xbps-install \
		qt5-wayland \
		qt5ct \
		konversation \
		qutebrowser \
		pdf.js
}
function qt5_desc () {
	echo "Install Qt5 for Wayland, plus Qutebrowser and Konversation."
}

function mozilla () {
	xbps-install firefox thunderbird
}
function mozzila_desc () {
	echo "Install Firefox and Thunderbird."
}

function office () {
	xbps-install \
		libreoffice \
		libreoffice-i18n-en-US \
		libreoffice-i18n-pt-BR
}
function office_desc () {
	echo "Install Libreoffice."
}

function pdf () {
	xbps-install zathura zathura-pdf-poppler
}
function pdf_desc () {
	echo "Install Zathura."
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
function flatpak_desc () {
	echo "Install Flatpak and supporting packages."
}

function embedded () {
	sudo xbps-install \
		arduino-cli \
		cross-arm-none-eabi \
		cross-arm-none-eabi-gdb \
		python3-pyserial \
		openocd \
		screen \
		sdcc
}
function embedded_desc () {
	echo "Install embedded toolchain and programmer/debugger software."
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
function kicad_desc () {
	echo "Install KiCad EDA and its resource packages."
}

function nonfree () {
	xbps-install void-repo-nonfree
	xbps-install -S intel-ucode
}
function nonfree_desc () {
	echo "Install nonfree repo and Intel microcode."
}

function ate () {
	xbps-install \
		tcc \
		gtk+3-devel \
		vte3-devel
}
function ate_desc () {
	echo "Install the packages necessary to use ate compiled by TCC."
}

MOST_PACKAGES="base term intel fonts themes wm audio media
 dev qt5 mozzila pdf popcorn"
COMPLEMENT_PACKAGES="uefi_bundle luks zfs security refind
 emacs office flatpak embedded kicad ate nonfree"

function install_most () {
	for target in $MOST_PACKAGES
	do
		$target
	done
}
function install_most_desc () {
	echo "Install [ ${MOST_PACKAGES} ]"
}

bold=$(tput bold)
normal=$(tput sgr0)

function print_help () {
	echo "${bold}Usage${normal}: ./void.sh <package-collection>"
	echo ""
	echo "These are the available package collections inside:"
	echo ""

	for target in $MOST_PACKAGES $COMPLEMENT_PACKAGES
	do
		echo "- ${bold}${target}${normal}: $(${target}_desc)"
	done

	echo ""
	echo "These are the available bundles:"
	echo ""
	for bundle in install_most
	do
		echo "- ${bold}${bundle}${normal}: $(${bundle}_desc)"
	done
}

# Run function from script:
# https://stackoverflow.com/questions/8818119/how-can-i-run-a-function-from-a-script-in-command-line
# Check if the function exists (bash specific)
if declare -f "$1" > /dev/null
then
	xbps-install -S
	# call first argument
	"$1"
else
	if [ -z $1 ]
	then
		print_help
	else
		echo "${1} is not a package collection"
		echo ""
		print_help
		exit 1
	fi
fi

