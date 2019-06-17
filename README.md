# dotfiles
These are the dotfiles for my i3wm or GNOME setup that runs on Arch Linux. The dotfiles
are managed by [GNU Stow](https://www.gnu.org/software/stow/).

## Installation (under Arch)

### Install Dependencies
```
$ sudo pacman -S oh-my-zsh-git zsh-autosuggestions zsh-syntax-highlighting spaceship-prompt-git stow awesome-terminal-fonts

```

### Clone dotfiles
```
$ git clone git@github.com:francoiscote/dotfiles.git ~/.dotfiles
```

## Usage
Create the symbolic links for each component you need.

```
$ cd ~/.dotfiles
$ stow i3 # or gnome
$ stow termite
$ stow ...[etc]
$ sudo chmod +x ~/.scripts/*
```

### Fonts

Follow the detailed instructions from the wiki, or go the quick way with the following scripts:
```
$ cd ~/.dotfiles
$ stow fonts
$ font-setup
```
