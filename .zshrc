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
