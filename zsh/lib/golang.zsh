if [[ -d /usr/local/go ]]; then
    [[ -d ~/go ]] && export GOPATH="$HOME/go" && path=($HOME/go/bin $path)
    path=(/usr/local/go/bin $path)
fi
