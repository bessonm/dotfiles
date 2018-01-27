# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bessonm/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
alias config='/var/run/current-system/sw/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'
