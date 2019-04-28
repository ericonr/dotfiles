# ericonr's dotfiles

Uses [GNU stow](https://www.gnu.org/software/stow/) for managing symlinks! The default `.stowrc` file is setup for my home directory, and for adopting files (overwrite existing files, bringing them into the repo).

In order to bring all files, use
```bash
$ stow */
```
otherwise, for specific folders, use
```bash
$ stow folder
```
