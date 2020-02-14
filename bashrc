# Basic {
# Set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Enables colorin the terminal bash shell export
export CLICOLOR=1

# Useful bash histroy configurations
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="history *:cd *:ls:ll:pwd:top:clear:exit"
export HISTTIMEFORMAT='%F %T  '
export HISTSIZE=2000
export HISTFILESIZE=10000

# Enable ctrl-s to search history forward (default to flow control, you rarely need it)
stty -ixon

# Use vi shortcut instead of default (emacs) for shell
#set -o vi
# }

# Aliases {
alias vi="vim"
alias ll="ls -lhp"
# }

# Functions {
# Get up several dirs up
function up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }

# Clear command historys
function clh() { cat /dev/null > ~/.bash_history && history -c; }
# }

# Environments {
# Enable bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Enable z
[ -f /usr/local/etc/profile.d/z.sh ] && . /usr/local/etc/profile.d/z.sh

# Enable fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# }

# Allow local customizations in "~/.bashrc_local"
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
