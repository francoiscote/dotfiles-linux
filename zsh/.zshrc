#!/bin/sh

# -----------------------------------------
# CONFIGS
# -----------------------------------------
DOTFILES=$HOME/.dotfiles
GREP_EXCLUDE_DIR="{.git,.sass-cache,artwork,node_modules}"
OS=`uname`
path=($DOTFILES/bin $path)
fpath=($DOTFILES/lib/completions $fpath)

export CLICOLOR=1
export QUOTING_STYLE=literal

# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/bin/google-chrome-stable

# -----------------------------------------
# Default GPG Key
# (if you fork this repo, change this to your own!)
# -----------------------------------------
export GPGKEY=60C853AA


# -----------------------------------------
# ZSH OPTIONS
# -----------------------------------------
setopt multios
setopt prompt_subst
setopt interactivecomments

autoload -U compaudit compinit

# -----------------------------------------
# PURE PROMPT CUSTOMIZATIONS
# -----------------------------------------
PURE_PROMPT_SYMBOL=">"

# -----------------------------------------
# ANTIGEN
# -----------------------------------------
source /usr/share/zsh/share/antigen.zsh

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

# -----------------------------------------
# PATHS
# -----------------------------------------
# Zsh
export PATH="$ZSH/bin:$PATH"
# scripts
export PATH="$HOME/.scripts:$PATH"
# local bin
export PATH="$HOME/.local/bin:$PATH"
# /usr/bin
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# ruby
export PATH="/home/fcote/.gem/ruby/2.4.0/bin:$PATH"
# Man Paths
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"


# -----------------------------------------
# SOURCE LIB/*.ZSH FILES
# -----------------------------------------
for config_file ($DOTFILES/zsh/lib/*.zsh); do
  source $config_file
done

# compinit must be done after sourcing all libs
compinit -i -d "${HOME}/.zcompdump"

# -----------------------------------------
# SHORTCUT COMMANDS
# -----------------------------------------
# c -> ~/Code/
c() { cd ~/Code/$1; }
_c() { _files -W ~/Code -/; }
compdef _c c

# h -> ~/
h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

# -----------------------------------------
# ALIASES
# -----------------------------------------

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Source my ZSH
alias reload!="source ~/.zshrc";

# -----------------------------------------
# RIGHT PROMPT
# -----------------------------------------
prompt_node() {
  local node_prompt
  if type node >/dev/null 2>&1; then
    node_prompt="$(node --version)"
  else
    return
  fi
  node_prompt=${node_prompt}
  NODE_ICON=$'\u2B22' # ⬢
  echo "%F{magenta}[$NODE_ICON $node_prompt]%F{reset}"
}
RPROMPT='$(prompt_node)'

# source private stuff in a .localrc file
if [[ -f $HOME/.localrc ]]; then
  source $HOME/.localrc
fi
