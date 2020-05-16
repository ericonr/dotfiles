#!/usr/bin/env bash

#            _
#   ___ _ __(_) ___ ___  _ __  _ __
#  / _ \ '__| |/ __/ _ \| '_ \| '__|
# |  __/ |  | | (_| (_) | | | | |
#  \___|_|  |_|\___\___/|_| |_|_|
#

# package installer for Void Linux

bold=$(tput bold)
normal=$(tput sgr0)

function print-bold() {
	printf "%s%s%s" "${bold}" "$1" "${normal}"
}

function print-item() {
	printf -- "- %s:" "$(print-bold $1)"
}

base="chrony elogind iwd vsv"
base_desc="$(print-item base) Install base system utilities."

luks="cryptsetup"
luks_desc="$(print-item luks) Install support for LUKS."

uefi_bundle="binutils gummiboot sbsigntool"
uefi_bundle_desc="$(print-item uefi_bundle) Install tools for creating UEFI bundles."

disk_tools="fscrypt udisks2"
disk_tools_desc="$(print-item disk_tools) Install fscrypt and UDisks2."

su_disk_tools="autofs hdparm"
su_disk_tools_desc="$(print-item su_disk_tools) Install AutoFS and hdparm"

refind="refind"
refind_desc="$(print-item refind) Install the rEFInd boot manager."

zfs="zfs zfsbootmenu"
zfs_desc="$(print-item zfs) Install support for ZFS."

security="apparmor"
security_desc="$(print-item security) Install security related packages."

popcorn="PopCorn"
popcorn_desc="$(print-item popcorn) Install PopCorn usage statistics."

term="bat bmon curl fd fish-shell gnupg2 htop mdcat neovim python3 p7zip ranger
 ripgrep starship stow tmux xtools vsv usbutils xz zstd zip bsdunzip bsdtar
 parallel"
term_desc="$(print-item term) Install basic terminal utilities."

ssh="fuse-sshfs rsync"
ssh_desc="$(print-item ssh) Install SSH utilities."

intel="intel-gpu-tools libva-intel-driver intel-media-driver mesa-intel-dri"
intel_desc="$(print-item intel) Install packages for media decode and GPU stuff in Intel-land."

fonts="font-awesome5 font-fira-ttf font-ibm-plex-ttf liberation-fonts-ttf
 noto-fonts-ttf noto-fonts-emoji ttf-bitstream-vera"
fonts_desc="$(print-item fonts) Basic fonts necessary for browsing the web and normal GUIs."

themes="breeze breeze-gtk breeze-snow-cursor-theme papirus-icon-theme"
themes_desc="$(print-item themes) Color and mouse themes for a good color setup."

wm="Waybar alacritty brightnessctl fzf grim jq mako redshift slurp sway swayidle
 swaylock wl-clipboard wofi go"
wm_desc="$(print-item wm) Install SwayWM and supporting packages. Depends on fonts and themes."

audio="alsa-utils playerctl pulseaudio pavucontrol"
audio_desc="$(print-item audio) Install PulseAudio and alsa."

media="bluez mpv mpv-mpris spotifyd spotify-tui youtube-dl"
media_desc="$(print-item media) Install the Elisa player, mpv, and spotify CLI programs."

dev="clang cmake make meson ninja git rustup tokei valgrind"
dev_desc="$(print-item dev) Install the CLang compiler, some build systems and rustup."

emacs="emacs-gtk3 hunspell hunspell-en_US hunspell-pt_BR shellcheck"
emacs_desc="$(print-item emacs) Install the GUI version of Emacs."

qt5="qt5-wayland qt5ct konversation qutebrowser pdf.js"
qt5_desc="$(print-item qt5) Install Qt5 for Wayland, plus Qutebrowser and Konversation."

elisa="elisa"
elisa_desc="$(print-item elisa) Install the Elisa music player."

mozilla="firefox thunderbird"
mozzila_desc="$(print-item mozilla) Install Firefox and Thunderbird."

office="libreoffice libreoffice-i18n-en-US libreoffice-i18n-pt-BR"
office_desc="$(print-item office) Install Libreoffice."

pdf="zathura zathura-pdf-poppler"
pdf_desc="$(print-item pdf) Install Zathura."

flatpak="flatpak xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils"
flatpak_desc="$(print-item flatpak) Install Flatpak and supporting packages."

embedded="arduino-cli cross-arm-none-eabi cross-arm-none-eabi-gdb python3-pyserial openocd screen sdcc"
embedded_desc="$(print-item embedded) Install embedded toolchain and programmer/debugger software."

kicad="kicad kicad-footprints kicad-library kicad-packages3D kicad-symbols kicad-templates"
kicad_desc="$(print-item kicad) Install KiCad EDA and its resource packages."

[ -z "$NO_NONFREE" ] && nonfree="intel-ucode nvidia"
nonfree_desc="$(print-item nonfree) Install nonfree pacakges: intel-ucode and nvidia."

ate="tcc gtk+3-devel vte3-devel pkgconf"
ate_desc="$(print-item ate) Install the packages necessary to use ate compiled by TinyCC."

void_docs="mdBook mdbook-linkcheck vmdfmt"
void_docs_desc="$(print-item void_docs) Install development tools for Void Docs."

xbps_devel="zlib-devel libressl-devel libarchive-devel"
xbps_devel_desc="$(print-item xbps_devel) Install development dependencies for XBPS."

base_env="$base $term $ssh $intel $fonts $themes $wm $audio $media $qt5 $popcorn
 $mozilla $pdf $emacs $security $su_disk_tools"
base_env_desc="$(print-item base_env) [ base term ssh intel fonts themes wm audio
 media qt5 popcorn mozilla pdf emacs security su_disk_tools ]"

all="$base_env $luks $uefi_bundle $disk_tools $refind $zfs $dev $elisa $office
 $flatpak $embedded $kicad $ate $nonfree $void_docs $xbps_devel"
all_desc="$(print-item all) [ base_env luks uefi_bundle disk_tools refind
 zfs dev elisa office flatpak embedded kicad ate nonfree void_docs xbps_devel ]"

function print_help () {
	cat <<EOF
$(print-bold Usage): $0 collection [collections...]

These are the available package collections:
$base_desc
$luks_desc
$uefi_bundle_desc
$disk_tools_desc
$su_disk_tools_desc
$refind_desc
$zfs_desc
$security_desc
$popcorn_desc
$term_desc
$ssh_desc
$intel_desc
$fonts_desc
$themes_desc
$wm_desc
$audio_desc
$media_desc
$dev_desc
$emacs_desc
$qt5_desc
$elisa_desc
$mozzila_desc
$office_desc
$pdf_desc
$flatpak_desc
$embedded_desc
$kicad_desc
$nonfree_desc
$ate_desc
$void_docs_desc
$xbps_devel_desc

These are the available bundles:
$base_env_desc
$all_desc

Recommended individual apps:
$(print-item bolt)
$(print-item cscope)
$(print-item lolcat-c)
$(print-item sl)
$(print-item podman)
$(print-item riot-desktop)
$(print-item sent)

$(print-bold "Environment variables:")
- ADDITIONAL_PACKAGES: env variable for individual packages
- NO_NONFREE: to disable nonfree repo
- YES: don't ask for confirmation
EOF

	exit
}


[ -n "$YES" ] && FLAGS="-y"

function check-nonfree() {
	if [ -z "$NO_NONFREE" ] ; then
		if xbps-query void-repo-nonfree >/dev/null ; then
			xbps-install $FLAGS -S void-repo-nonfree
			xbps-install -S
		fi
	else
		echo "Non-free packages are disabled"
	fi
}

if [ -z "$1" ] ; then
	print_help
else
	xbps-install -S
	xbps-install $FLAGS -u xbps
	check-nonfree
	echo "Collections: $@"

	for coll in "$@"
	do
		if [ -z "${!coll}" ] ; then
			echo "$coll doesn't exist"
			exit
		fi
		packages+=" ${!coll}"
	done

	packages+=" $ADDITIONAL_PACKAGES"
	echo "Packages: $packages"

	xbps-install $FLAGS $packages
fi
