autoload epoch
autoload zcalc

for file in ~/.zsh/lib/*.zsh; do
    source $file
done

if [[ -x /usr/local/bin/vim ]]; then
	export EDITOR=/usr/local/bin/vim
else
	export EDITOR=/usr/bin/vim
fi

export EMAIL='[%full_name%] <[%email_address%]>'
export PAGER="/usr/bin/less -R"
export LC_MESSAGES=C

setopt NO_AUTO_CD
setopt NO_AUTO_MENU
setopt COMPLETE_IN_WORD
setopt CASE_GLOB
setopt CASE_MATCH
setopt NO_FLOW_CONTROL
setopt INTERACTIVE_COMMENTS
unsetopt NOMATCH

alias lh='ls -lh'
alias eog=gpicview
alias tmw='tmux rename-window "$(basename "$(pwd)")"'

if [[ -r ~/.zshrc_local ]]; then
    source ~/.zshrc_local
fi
