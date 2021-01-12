##
## Custom .bashrc for Ubuntu/Debian server
##

## Set $PATH, which tells the computer where to search for commands
export PATH="$PATH:/usr/sbin:/sbin:/bin:/usr/bin:/etc:/usr/ucb:/usr/local/bin:/usr/local/local_dfs/bin:/usr/bin/X11:/usr/local/sas"

## Set the promt to display user, hostname and the current direcotry
PS1="\[\033[1m\]\[\033[33m\][ \[\033[32m\]\u@\h\[\033[33m\]: \[\033[36m\]\w \[\033[33m\]]\$ \[\033[0m\]"

## Set NANO as the default editor
EDITOR=/usr/bin/nano
export EDITOR

### Alias stuff ###

# Get the public IP address
alias ipp="curl ifconfig.co"

# Nginx server control
alias nginxtest="sudo service nginx testconfig"
alias nginxstop="sudo service nginx stop"
alias nginxstart="sudo service nginx start"
alias nginxreload="sudo service nginx reload"
alias nginxstatus="sudo service nginx status"

# Package managing
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias upgradey="sudo apt upgrade -y"
alias upgradel="sudo apt list --upgradable"
alias remove="sudo apt remove"
alias autoremove="sudo apt autoremove"

# Some more aliases
alias grep="grep --color=auto"
alias ls="ls --color=auto"
