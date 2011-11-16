export EDITOR='/usr/bin/vim'
export PAGER='/usr/bin/less'
export CVSROOT='/home/cvsroot'
export PYTHONSTARTUP='/home/zwon/.pythonrc'
export EMAIL='[%full_name%] <[%email_address%]>'
export LC_MESSAGES=C

HISTCONTROL=ignoreboth:erasedups
HISTFILESIZE=5000
HISTTIMEFORMAT="%v %T "

shopt -s cdable_vars checkwinsize

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -x ~/bin/perldoc-complete.pl ] ; then
    complete -C perldoc-complete.pl -o nospace -o default perldoc
fi

# If running interactively, then:
if [ "$PS1" ]; then
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias lh='ls -lh'
    alias la='ls -A'
    alias ns='netstat --inet --inet6 -anp'
    alias nse='sudo netstat -tanp | grep -v LISTEN'
    alias nsl='sudo netstat -tanp | grep LISTEN'
    alias nsu='sudo netstat -uanp'
    alias nsr='netstat -rn'
    alias vimrc='vim ~/.bashrc'
    alias src='source ~/.bashrc'
    alias eog='eog 2>/dev/null'
    alias s='screen -R -D'
    pack() { ps ax | grep "$1"; }

    case $TERM in
        xterm*|rxvt*|linux*|screen*)
            PS1='\[\033[1;33m\]\!\[\033[1;36m\]\u@\h:\[\033[1;39m\]\w\n\l \[\033[1;36m\]\t \[\033[1;39m\]\$\[\033[0m\] '
            eval `dircolors -b`
	    ;;
	*)
	    PS1='\u@\h:\w \$ '
	    ;;
    esac
fi
[ -f ~/perl5/perlbrew/etc/bashrc ] && source ~/perl5/perlbrew/etc/bashrc
