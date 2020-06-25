#!/bin/sh

#            _
#   ___ _ __(_) ___ ___  _ __  _ __
#  / _ \ '__| |/ __/ _ \| '_ \| '__|
# |  __/ |  | | (_| (_) | | | | |
#  \___|_|  |_|\___\___/|_| |_|_|
#

# package installer for Void Linux

bold=$(tput bold)
normal=$(tput sgr0)

print_bold() {
	printf "%s%s%s" "${bold}" "$1" "${normal}"
}

print_item() {
	printf -- "- %s:" "$(print_bold $1)"
}

nonfree() {
	[ -z "$NO_NONFREE" ] && echo "$@"
}

base="chrony elogind iwd vsv"
base_desc="$(print_item base) Install base system utilities."

luks="cryptsetup"
luks_desc="$(print_item luks) Install support for LUKS."

uefi_bundle="binutils gummiboot sbsigntool"
uefi_bundle_desc="$(print_item uefi_bundle) Install tools for creating UEFI bundles."

disk_tools="fscrypt udisks2"
disk_tools_desc="$(print_item disk_tools) Install fscrypt and UDisks2."

su_disk_tools="autofs hdparm"
su_disk_tools_desc="$(print_item su_disk_tools) Install AutoFS and hdparm"

refind="refind"
refind_desc="$(print_item refind) Install the rEFInd boot manager."

zfs="zfs zfsbootmenu linux-headers"
zfs_desc="$(print_item zfs) Install support for ZFS."

security="apparmor"
security_desc="$(print_item security) Install security related packages."

popcorn="PopCorn"
popcorn_desc="$(print_item popcorn) Install PopCorn usage statistics."

_browser="ncdu ranger"
_device="usbutils"
_monitor="bmon htop"
_net="curl git gnupg2"
_shell="fish-shell lolcat-c starship tmux"
_tools="bat bsdtar dos2unix fd mdcat neovim p7zip parallel ripgrep stow"
_void="vsv xtools graphviz"
_info="man-pages-devel"
term="python3 ${_browser} ${_device} ${_monitor} ${_net} ${_shell} ${_tools} ${_void}
 ${_info}"
term_desc="$(print_item term) Install basic terminal utilities."

ssh="fuse-sshfs rsync"
ssh_desc="$(print_item ssh) Install SSH utilities."

intel="intel-gpu-tools libva-intel-driver intel-media-driver mesa-intel-dri
 intel-undervolt $(nonfree intel-ucode)"
intel_desc="$(print_item intel) Install packages for media decode and GPU stuff in Intel-land."

nvidia="$(nonfree nvidia nvidia-opencl linux-headers)"
nvidia_desc="$(print_item nvidia) Install NVIDIA drivers."

graphics="Vulkan-Tools clinfo mesa-demos"
graphics_desc="$(print_item graphics) Install graphics stack testing tools."

fonts="font-awesome5 font-fira-ttf font-ibm-plex-ttf liberation-fonts-ttf
 noto-fonts-ttf noto-fonts-emoji ttf-bitstream-vera"
fonts_desc="$(print_item fonts) Basic fonts necessary for browsing the web and normal GUIs."

themes="breeze-snow-cursor-theme breeze-amber-cursor-theme breeze-gtk papirus-icon-theme"
themes_desc="$(print_item themes) Color and mouse themes for a good color setup."

wm="Waybar alacritty brightnessctl fzf grim jq mako redshift slurp sway swayidle
 swaylock wl-clipboard wofi go"
wm_desc="$(print_item wm) Install SwayWM and supporting packages. Depends on fonts and themes."

wayland="wf-recorder wayfire wf-shell cage waypipe"
wayland_desc="$(print_item wayland) Install Wayfire and Cage."

xorg="xfce4 xorg"
xorg_desc="$(print_item xorg) Install XFCE4 and Xorg."

audio="alsa-utils playerctl pulseaudio pavucontrol"
audio_desc="$(print_item audio) Install PulseAudio and alsa."

media="bluez mpv mpv-mpris youtube-dl spotifyd spotify-tui imv ImageMagick"
media_desc="$(print_item media) Install mpv, imv and spotify CLI programs."

dev="clang cmake make meson ninja rustup tokei valgrind gdb strace"
dev_desc="$(print_item dev) Install the CLang compiler, some build systems and rustup."

emacs="emacs-gtk3 hunspell hunspell-en_US hunspell-pt_BR shellcheck zstd"
emacs_desc="$(print_item emacs) Install the GUI version of Emacs."

qute="qt5-wayland qutebrowser pdf.js"
qute_desc="$(print_item qute) Install Qt5 for Wayland and Qutebrowser."

qt5="qt5-wayland qt5ct konversation"
qt5_desc="$(print_item qt5) Install Qt5 for Wayland, Konversation and qt5ct."

mozilla="firefox thunderbird"
mozzila_desc="$(print_item mozilla) Install Firefox and Thunderbird."

office="libreoffice libreoffice-i18n-en-US libreoffice-i18n-pt-BR"
office_desc="$(print_item office) Install Libreoffice."

pdf="zathura zathura-pdf-poppler"
pdf_desc="$(print_item pdf) Install Zathura."

flatpak="flatpak xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils"
flatpak_desc="$(print_item flatpak) Install Flatpak and supporting packages."

embedded="arduino-cli cross-arm-none-eabi cross-arm-none-eabi-gdb
 python3-pyserial openocd screen sdcc"
embedded_desc="$(print_item embedded) Install embedded toolchain and programmer/debugger software."

qemu="qemu proot qemu-user-static"
qemu_desc="$(print_item qemu) Install QEMU, proot."

kicad="kicad kicad-footprints kicad-library kicad-packages3D kicad-symbols kicad-templates"
kicad_desc="$(print_item kicad) Install KiCad EDA and its resource packages."

ate="tcc gtk+3-devel vte3-devel pkgconf"
ate_desc="$(print_item ate) Install the packages necessary to use ate compiled by TinyCC."

void_docs="mdBook mdbook-linkcheck pandoc vmdfmt"
void_docs_desc="$(print_item void_docs) Install development tools for Void Docs."

xbps_devel="zlib-devel libressl-devel libarchive-devel"
xbps_devel_desc="$(print_item xbps_devel) Install development dependencies for XBPS."

base_env="$base $term $ssh $intel $fonts $themes $wm $audio $media $qute $popcorn
 $mozilla $pdf $emacs $security $su_disk_tools"
base_env_desc="$(print_item base_env) [ base term ssh intel fonts themes wm audio
 media qute popcorn mozilla pdf emacs security su_disk_tools ]"

current_system="$base_env $zfs $wayland $uefi_bundle"
current_system_desc="$(print_item current_system) [ base_env zfs wayland uefi_bundle ]"

all="$base_env $luks $uefi_bundle $disk_tools $refind $zfs $dev $office $qt5
 $flatpak $embedded $kicad $ate $void_docs $xbps_devel $nvidia $graphics $xorg"
all_desc="$(print_item all) [ base_env luks uefi_bundle disk_tools refind
 zfs dev office flatpak embedded kicad ate void_docs xbps_devel
 xorg nvidia graphics qt5 ]"

print_help () {
	cat <<EOF
$(print_bold Usage): $0 collection [collections...]

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
$nvidia_desc
$graphics_desc
$fonts_desc
$themes_desc
$wm_desc
$xorg_desc
$wayland_desc
$audio_desc
$media_desc
$dev_desc
$emacs_desc
$qt5_desc
$qute_desc
$mozzila_desc
$office_desc
$pdf_desc
$flatpak_desc
$embedded_desc
$kicad_desc
$ate_desc
$void_docs_desc
$xbps_devel_desc

These are the available bundles:
$base_env_desc
$current_system_desc
$all_desc

Recommended individual apps:
$(print_item bolt) control thunderbolt port
$(print_item cscope) inspect code
$(print_item elisa) music player
$(print_item fstl) STL visualizer
$(print_item fwupd) system firmware updater
$(print_item hugo) static site generator
$(print_item podman) container tool
$(print_item riot-desktop) Matrix client
$(print_item sent) presentation thingy
$(print_item sl) choo-choo

$(print_bold "Environment variables:")
- ADDITIONAL_PACKAGES: env variable for individual packages
- NO_NONFREE: to disable nonfree repo
- FLAGS: additional flags
- BOOTSTRAP: bootstrap an installation
- ROOTDIR: root directory
EOF

	exit
}

[ -n "$ROOTDIR" ] && FLAGS="-r${ROOTDIR} ${FLAGS}"
[ -n "$BOOTSTRAP" ] &&
	FLAGS="-Rhttps://mirror.clarkson.edu/voidlinux/current
		   -Rhttps://mirror.clarkson.edu/voidlinux/current/musl
		   -S ${FLAGS}"

XBPS_INSTALL="xbps-install ${FLAGS}"
XBPS_QUERY="xbps-query ${FLAGS}"

check_nonfree() {
	if [ -z "$NO_NONFREE" ] ; then
		if ! $XBPS_QUERY void-repo-nonfree >/dev/null ; then
			$XBPS_INSTALL -S void-repo-nonfree
			$XBPS_INSTALL -S
		fi
	else
		echo "Non-free packages are disabled"
	fi
}

if [ -z "$1" ] ; then
	print_help
else
	if [ "$BOOTSTRAP" ]; then
		$XBPS_INSTALL -S base-system
	else
		$XBPS_INSTALL -S
		$XBPS_INSTALL -u xbps
	fi

	check_nonfree
	echo "Collections: $@"

	for coll in "$@"
	do
		if [ -z "${coll}" ] ; then
			echo "$coll doesn't exist"
			exit
		fi
		eval "new_packages=\"\$$coll\""
		packages="${packages} ${new_packages}"
	done

	packages="${packages} $ADDITIONAL_PACKAGES"
	echo "Packages: ${packages}"

	$XBPS_INSTALL $packages

	for coll in "$@"
	do
		if [ -r "void.sh.hooks/$coll" ] ; then
			command "void.sh.hooks/$coll"
		fi
	done
fi
