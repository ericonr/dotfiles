# ericonr's dotfiles

[![forthebadge](https://forthebadge.com/images/badges/powered-by-electricity.svg)](https://forthebadge.com)

Uses [GNU stow](https://www.gnu.org/software/stow/) for managing symlinks! The
default `.stowrc` file is setup for my home directory, and for adopting files
(overwrite existing files, bringing them into the repo).

In order to link the usual files, use

```
$ ./stow-linux.sh
```

otherwise, for specific folders, use

```
$ stow <folder>
```

It's also recommended to create the `~/.local/bin` and `~/.local/share`
directories before stowing the repository.

## Wayfire or Sway

This setup, dotfiles for which can be found inside `wayland/`, requires the
dependencies listed under `wm` and `wayland` in `void/void.sh`.

- Theming:
   - [Liberation font](https://en.wikipedia.org/wiki/Liberation_fonts) (Sans).
   - [IBM Plex font](https://www.ibm.com/plex/).
   - [Breeze_Snow](https://github.com/KDE/breeze) cursor theme.

**Obs.:** This configuration requires some executables that can be obtained from
the [sourcecode/](#sourcecode) directory.

### Wallpaper

![wallpaper](https://gitlab.com/Kreneker/the-grand-canyon/raw/master/The%20Grand%20Canyon%20preview.png)

The wallpaper is from one of the finalists of the [Plasma 5.18 Wallpaper
Contest](https://dot.kde.org/2020/01/24/volna-wins-plasma-518-wallpaper-contest)!
Congratulations to all of them :D

I specially loved kevintee's colors, so I'm using their wallpaper, which is
available here as a convenience, but still under their license. You can find
other versions of it at their
[repo](https://gitlab.com/Kreneker/the-grand-canyon).

## neovim plugins

The Neovim config uses git submodules to store some plugins, which can be found
under `nvim/.config/nvim/pack/plugins/start/`.

If you want to use these plugins, you can download them using:

```
$ git clone --recursive https://github.com/ericonr/dotfiles.git
```

## Embedded development

This setup for embedded development, especially on the arm-none-eabi platform,
can be found on `embedded/`. It requires the dependencies listed under
`embedded` in `void/void.sh`, and the following others:

- [STM32CubeProg](https://www.st.com/en/development-tools/stm32cubeprog.html):
   the programmer for cases when OpenOCD doesn't work.
- [STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html): the
   tool used for generating STM32 projects.
- [`esp-idf`](https://github.com/espressif/esp-idf): the Espressif IoT
   Development Framework. Still requires the download of an actual ESP32
   compiler.
- [`ugdb`](https://github.com/ftilde/ugdb): the best GDB interface! Helps a lot
   in usability.
- [`can-utils`](https://github.com/linux-can/can-utils): Utilities for debugging
   and using the CAN bus on Linux.
