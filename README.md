# ericonr's dotfiles

[![forthebadge](https://forthebadge.com/images/badges/powered-by-electricity.svg)](https://forthebadge.com)

Uses [GNU stow](https://www.gnu.org/software/stow/) for managing symlinks! The default `.stowrc` file is setup for my home directory, and for adopting files (overwrite existing files, bringing them into the repo).

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

This setup, which can be found on `wm` and `script`, requires the following dependencies:
* Basic setup:
  * `sway`: the Wayland compositor and tiling window manager.
    * `swaylock`
    * `swaybg`
    * `swayidle`
  * `Xwayland`: X server inside Wayland, for backwards compatibility.
  * `waybar`: customizable status bar.
  * `jq`: CLI JSON parser, necessary for keyboard layout implementation.
  * `redshift`: magic tool for avoiding eye burning. Needs to be the version patched for Sway/Wayland use.
* Default applications:
  * `fish`: the default shell.
	* `starship`: the prompt for fish.
  * `alacritty`: the default terminal emulator (and it has the `dimensions` option).
    * `tmux`: the main terminal shortcut launches `tmux` for multiple terminals in the same screen.
  * `emacs`: the default text editor (unfortunately, has to run through Xwayland).
  * `nvim`: the default CLI text editor.
  * `launcher`: used as a standalone launcher, it requires a few details dependencies:
    * `fzf`: a wonderful fuzzy searcher.
	* `lnch`: a really simple Go program for launching an application. Can be obtained by running the makefile inside `sourcecode`.
  * `spotify-tui`: TUI for Spotify.
    * `spotifyd`: daemon for streaming Spotify stuff.
* Applications needed for media keys:
  * `pulseaudio`: the default audio daemon; `pactl` is used for controlling the volume.
  * `brightnessctl`: the default brightness controller; it's used for setting the backlight.
  * `playerctl`: player control from media keys.
  * `grim`: screenshots on wayland.
    * `slurp`: select a geometry on a wayland screen.
  
**Obs:** A few needed programs can be installed by running the Makefile inside `sourcecode/`.
