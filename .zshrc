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

# Add user bin to path
export PATH=~/"bin:${PATH}"

# Aliases
alias config='/var/run/current-system/sw/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

# Function

# batch unzip and move files
autoload zmv
zmodload zsh/files
mkmv() {
  if [[ $argv[-1]:h = [a-zA-Z] ]]
    then dir=$argv[-1]:h;
    else dir='#';
  fi
  mkdir -p -- $dir && mv $argv[2] $dir/$argv[2];
}

batchmove() {zmv -Qp mkmv "(?)*.$1(^-/)" '${(U)1}/$f'}

# zmv a function to safely batch-rename files using zsh powerful pattern matching and expansion operators as an autoloadable function.
# mkmv: a function that acts like mv except that it also creates the parent directory of the target if need be.
# $argv[-1]: $argv like $* is the list of positional parameters, $argv[-1] is the last one. Here, same as $3 as zmv calls it as mkmv -- source destination
# $var:h: like in csh, gets the head of the variable, that is the dir name.
# zmodload zsh/files: loads a module that enables the builtin version of a few file handling utilities including mkdir and mv, here giving a significative performance enhancement as we're calling both for each file.
# -Q: enable bare glob qualifiers in the pattern. Theses days, another option is to rewrite (^-/) as (#q^-/).
# -p mkmv, tell zmv to use our mkmv function as the program to do the renaming instead of mv
# (?)*(^-/): a pattern (?)* with a glob qualifier used to match the files to rename. The ? (to match a single character) in parenthesis is captured so it can be referred to as $1 in the replacement.
# (^-/): glob qualifiers used to match files based on more criteria than just their name:
#     ^: negate the following qualifiers
#     -: for the following qualifiers, for symlinks, consider the attribute of the target of the link instead of the link itself.
#     /: select files of type directory. With the previous two qualifiers, that means we want files that are neither directories nor symlinks to directories.
# ${(U)1}: the captured first character of the matched file, converted to uppercase with the U parameter expansion flag
# $f in the replacement refers to the full path of the matched file.
