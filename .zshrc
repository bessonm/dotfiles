HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd notify
unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/bessonm/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
alias config='/var/run/current-system/sw/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

eval "$(direnv hook zsh)"

# ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.current_ssh_agent
    eval "$(<~/.current_ssh_agent)"
    ssh-add /home/bessonm/.ssh/id_rsa_github
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.current_ssh_agent)" > /dev/null
fi

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
#bindkey '^[[A' up-line-or-beginning-search # Up
#bindkey '^[[B' down-line-or-beginning-search # Down
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

bindkey '^[[1;5C' forward-word  # [Ctrl-Right]
bindkey '^[[1;5D' backward-word # [Ctrl-Left]
