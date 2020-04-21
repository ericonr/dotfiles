# ericonr's dotfiles

[![forthebadge](https://forthebadge.com/images/badges/powered-by-electricity.svg)](https://forthebadge.com)

Uses [GNU stow](https://www.gnu.org/software/stow/) for managing symlinks! The default `.stowrc` file is setup for my home directory, and for adopting files (overwrite existing files, bringing them into the repo).

Also uses [Go](https://golang.org/) programs to perform a few tasks.

In order to link all files, use

```bash
$ stow */
```

otherwise, for specific folders, use

```bash
$ stow folder
```

It's also recommended to create the `~/.local/bin` and `~/.local/share` directories before stowing the repository.

## Sway + Waybar

This setup, which can be found inside `wayland`, requires the following dependencies:
* Basic setup:
  * [`sway`](https://swaywm.org/): the Wayland compositor and tiling window manager.
    * [`swaylock`](https://github.com/swaywm/swaylock)
    * [`swaybg`](https://github.com/swaywm/swaybg)
    * [`swayidle`](https://github.com/swaywm/swayidle)
  * [`Xwayland`](https://wayland.freedesktop.org/xserver.html): X server inside Wayland, for backwards compatibility.
  * [`waybar`](https://github.com/Alexays/Waybar): customizable status bar.
  * [`wofi`](https://hg.sr.ht/~scoopta/wofi): a pretty good menu system, for wayland (replaces the self built launcher).
  * [`mako`](https://wayland.emersion.fr/mako/): a notification daemon
  * [`jq`](https://stedolan.github.io/jq/): CLI JSON parser, necessary for keyboard layout implementation.
  * [`redshift`](https://github.com/minus7/redshift/tree/wayland): magic tool for avoiding eye burning. Needs to be the version patched for Sway/Wayland use.
* Default applications:
  * [`fish`](https://fishshell.com/): the default shell.
	* [`starship`](https://starship.rs/): the cross-shell prompt for astronauts.
  * [`alacritty`](https://github.com/jwilm/alacritty): the default terminal emulator (because it's pretty, fast, and it has the `dimensions` option).
    * [`tmux`](https://github.com/tmux/tmux): the Meta+T shortcut launches `tmux` for multiple terminals in the same screen.
  * [`emacs`](https://www.gnu.org/software/emacs/): the no longer default text editor (unfortunately, it has to run through Xwayland).
  * [`neovim`](https://neovim.io/): the default CLI text editor.
  * [`fzf`](https://github.com/junegunn/fzf): a wonderful fuzzy searcher, required by the self-built launcher.
  * [`ranger`](https://ranger.github.io/): a VIM-like TUI file manager.
* Applications needed for media keys:
  * [`pulseaudio`](https://www.freedesktop.org/wiki/Software/PulseAudio/): the default audio daemon; provides `pactl`, which is used for controlling the volume.
  * [`brightnessctl`](https://github.com/Hummer12007/brightnessctl): the default brightness controller; it's used for setting the backlight.
  * [`playerctl`](https://github.com/altdesktop/playerctl): player control from media keys.
  * [`grim`](https://wayland.emersion.fr/grim/): screenshots on wayland.
    * [`slurp`](https://wayland.emersion.fr/slurp/): select a geometry on a wayland screen.
* Media applications:
  * [`spotify-tui`](https://github.com/Rigellute/spotify-tui): a Spotify TUI.
    * [`spotifyd`](https://github.com/Spotifyd/spotifyd): a Spotify daemon.
  * [`mpv`](https://mpv.io/): great player for everything.
    * [`mpv-mpris`](https://github.com/hoyon/mpv-mpris): MPV plugin to allow it to be controlled from playerctl.
    * [`youtube-dl`](https://youtube-dl.org/): allows MPV to stream YouTube videos.
* Applications needed for AppPauser keys:
  * [`AppPauser`](https://github.com/ericonr/AppPauser): is used for making pausing the execution of any application that's started by it possible.
* Theming:
  * [Liberation font](https://en.wikipedia.org/wiki/Liberation_fonts) (Sans).
  * [IBM Plex font](https://www.ibm.com/plex/).
  * [Breeze\_Snow](https://github.com/KDE/breeze) cursor theme.

**Obs.:** This configuration requires some executables that can be obtained from the `sourcecode/` directory.

### Wallpaper

![wallpaper](https://gitlab.com/Kreneker/the-grand-canyon/raw/master/The%20Grand%20Canyon%20preview.png)

The wallpaper is from one of the finalists of the [Plasma 5.18 Wallpaper Contest](https://dot.kde.org/2020/01/24/volna-wins-plasma-518-wallpaper-contest)! Congratulations to all of them :D

I specially loved kevintee's colors, so I'm using their wallpaper, which is available here as a convenience, but still under their license. You can find other versions of it at their [repo](https://gitlab.com/Kreneker/the-grand-canyon).

## `sourcecode`

To install the executables inside this directory, it's necessary to run

```shell
go install ./...
```

inside it.

## neovim plugins

Neovim now uses git submodules to store some plugins:

* [vim-airline](https://github.com/vim-airline/vim-airline)
* [kotlin-vim](https://github.com/udalov/kotlin-vim)

If you want to use these plugins, you can download them using:

```shell
git clone --recursive https://github.com/ericonr/dotfiles.git
```

## Embedded development

This setup for embedded development, especially on the arm-none-eabi platform, can be found on `embedded/`. It requires the following dependencies:
* [`arm-none-eabi-gcc/gdb/newlib`](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads): the arm-none-eabi compiler, debugger and libc.
* [`openocd`](http://openocd.org/): the debugger/programmer software used in most cases.
* [STM32CubeProg](https://www.st.com/en/development-tools/stm32cubeprog.html): the programmer for cases when OpenOCD doesn't work.
* [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html): the tool used for generating STM32 projects.
* [`esp-idf`](https://github.com/espressif/esp-idf): the Espressif IoT Development Framework. Still requires the download of an actual ESP32 compiler.
* [`ugdb`](https://github.com/ftilde/ugdb): the best GDB interface! Helps a lot in usability.
* [`can-utils`](https://github.com/linux-can/can-utils): Utilities for debugging and using the CAN bus on Linux.

