unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/$USER/.zshrc'

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# history options
setopt auto_cd # cd by typing directory name if it's not a command
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt hist_ignore_space
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances
#setopt correct_all # autocorrect commands
setopt interactive_comments # allow comments in interactive shells

# history navigation
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

# autocompletion
autoload -Uz compinit

# autocompletion optim
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || 
stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# highlight and select completion results
zmodload -i zsh/complist

# completion style & navigation
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# use direnv
eval "$(direnv hook zsh)"

# load ssh-agent keys
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.current_ssh_agent
    eval "$(<~/.current_ssh_agent)"
    ssh-add /home/bessonm/.ssh/id_rsa_github
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.current_ssh_agent)" > /dev/null
fi

# cmd line words navigation
bindkey '^[[1;5C' forward-word  # [Ctrl-Right]
bindkey '^[[1;5D' backward-word # [Ctrl-Left]

# aliases
alias config='/var/run/current-system/sw/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'
alias idea='$HOME/opt/idea/bin/idea.sh&'

# antibody plugins
source ~/.zsh_plugins.sh

# Disable Software Flow Control (XON/XOFF)
stty -ixon

# PyWal Colors

## For Polybar transparency w/ pywal
## @see https://github.com/dylanaraps/pywal/issues/132
# source ~/.cache/wal/colors.sh

## Export envar with alpha set.
# export background_alpha="#80${color0/'#'}"
# export foreground_alpha="#BF${color7/'#'}"

## Terminal colors
# (cat ~/.cache/wal/sequences &)

