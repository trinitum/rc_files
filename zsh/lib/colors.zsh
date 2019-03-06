local uname
uname=$(command uname)

case $uname in
    FreeBSD|Darwin)
        alias ls='ls -G'
        ;;
    Linux)
        alias ls='ls --color=auto'
        ;;
esac

if echo y | grep --color=auto . &> /dev/null; then
    alias grep='grep --color=auto'
fi
