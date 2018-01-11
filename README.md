# dotfiles
These are the dotfiles for my GNOME3 or i3 setup that run on Arch Linux. The dotfiles
are managed by [GNU Stow](https://www.gnu.org/software/stow/).

## Installation (under Arch)
```
$ sudo pacman -S stow
$ git clone git@github.com:francoiscote/dotfiles-gnome.git ~/.dotfiles
```

## Usage
Create the symbolic links for each component you need.

```
$ cd ~/.dotfiles
$ stow gnome # or i3
$ stow termine
$ stow ...
$ sudo chmod +x ~/.scripts/*
```

### zsh
`zsh` depends on (antigen)[https://github.com/zsh-users/antigen/] (available on the AUR for Arch).
```
$ yay -S antigen-git
$ cd ~/.dotfiles
$ stow zsh
```
Open a new shell prompt for antigen to install the dependencies.

### Fonts

Follow the detailed instructions from the wiki, or go the quick way with the following scripts:
```
$ cd ~/.dotfiles
$ stow fonts
$ font-setup
```
