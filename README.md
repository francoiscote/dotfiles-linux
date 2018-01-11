# dotfiles-gnome
These are the dotfiles for my GNOME3 setup that runs on Arch Linux. The dotfiles
are managed by [GNU Stow](https://www.gnu.org/software/stow/).

## Installation (under Arch)
```
$ sudo pacman -S stow
$ git clone git@github.com:francoiscote/dotfiles-gnome.git ~/.dotfiles
```

## Usage
Create the symbolic links for each component you need

```
$ cd ~/.dotfiles
$ stow gnome
$ stow zsh
$ stow ...
```

See the wiki for more information.
