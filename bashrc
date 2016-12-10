export EDITOR='/usr/bin/vim'
export PAGER='/usr/bin/less -R'
export EMAIL='[%full_name%] <[%email_address%]>'
export LC_MESSAGES=C

HISTCONTROL=ignoreboth:erasedups
HISTFILESIZE=unlimited
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
    case `uname` in
        FreeBSD|Darwin)
            alias ls='ls -G'
            ;;
        Linux)
            alias ls='ls --color=auto'
            ;;
    esac
    alias ll='ls -l'
    alias lh='ls -lh'
    alias nse='sudo netstat -tanp | grep -v LISTEN'
    alias nsl='sudo netstat -tanp | grep LISTEN'
    alias vimrc='vim ~/.bashrc'
    alias src='source ~/.bashrc'
    alias eog='gpicview'
    alias s='tmux new -AD -s default'
    alias tmw='tmux rename-window "$(basename "$(pwd)")"'
    pmver() { perl -M$1 -E"say $1->VERSION"; }
    epoch() {
        date --date @$1 +"%F %T %Z %:z"
        TZ=UTC date --date @$1 +"%F %T %Z"
    }
    ssht() {
        [ -n $TMUX ] && tmux rename-window "$*"
        command ssh "$@" \
            -t 'mesg n; which tmux && ( tmux attach || tmux new ) || bash'
        [ -n $TMUX ] && tmux set-window-option -q automatic-rename "on"
    }

    if declare -f __git_ps1 >/dev/null ; then
        GIT_BRANCH='$(__git_ps1)'
    fi
    GIT_PS1_SHOWDIRTYSTATE='true'
    GIT_PS1_SHOWSTASHSTATE='true'
    GIT_PS1_SHOWUNTRACKEDFILES='true'

    case $TERM in
        xterm*|rxvt*|linux*|screen*)
            XTERM_TITLE=''
            if [ "x$SSH_CONNECTION" == "x" ]; then
                if [ $TERM == 'xterm' ]; then
                    XTERM_TITLE='\[\033]0;\w\007\]'
                fi
                if [ "x$SUDO_USER" == "x" ]; then
                    PSCLR1='\[\033[1;36m\]'
                else
                    PSCLR1='\[\033[1;31m\]'
                fi
            else
                XTERM_TITLE='\[\033]0;\h:\w\007\]'
                PSCLR1='\[\033[1;32m\]'
            fi
            PS1=$XTERM_TITLE'\[\033[1;33m\]\u'$PSCLR1'@\h:\[\033[1;39m\]\w\n'$PSCLR1'\t'$GIT_BRANCH' \[\033[1;39m\]\$\[\033[0m\] '
            [ -x /usr/bin/dircolors ] && eval `dircolors -b`
	    ;;
	*)
	    PS1='\u@\h:\w'$GIT_BRANCH' \$ '
	    ;;
    esac

    mesg n
fi

if [ -d /usr/local/go ]; then
    [ -d ~/go ] && export GOPATH="$HOME/go" && PATH="$PATH:$GOPATH/bin"
    export GOROOT=/usr/local/go
    PATH="$PATH:$GOROOT/bin"
fi

[ -f ~/perl5/perlbrew/etc/bashrc ] && source ~/perl5/perlbrew/etc/bashrc
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
