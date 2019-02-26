# Path to oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode z)

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

source $ZSH/oh-my-zsh.sh
local ret_status="%(?:%{$fg_bold[green]%}✔ :%{$fg_bold[red]%}✖ )"
PROMPT='${ret_status}%F{yellow}%n%F{cyan}@%m:%F{white}%d
%F{cyan}%T $(git_prompt_info)$(git_repo_status)%F{white}%B%%%{$reset_color%} '
ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
function git_repo_status() {
    local INDEX STATUS
    INDEX=$(command git status --porcelain 2> /dev/null) || return 0
    STATUS=""
    if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
        STATUS="%F{yellow}$"
    fi
    if $(echo "$INDEX" | command grep -E '^\?' &> /dev/null); then
        STATUS="%F{red}%%$STATUS"
    fi
    if $(echo "$INDEX" | command grep -E '^.[A-Z]' &> /dev/null); then
        STATUS="%F{red}*$STATUS"
    fi
    if $(echo "$INDEX" | command grep -E '^[A-Z]' &> /dev/null); then
        STATUS="%F{green}+$STATUS"
    fi
    echo "$STATUS%F{green}) "
}


# User configuration
if [[ -x /usr/local/bin/vim ]]; then
    export EDITOR='/usr/local/bin/vim'
else
    export EDITOR='/usr/bin/vim'
fi
export PAGER='/usr/bin/less -R'
export EMAIL='[%full_name%] <[%email_address%]>'
export LC_MESSAGES=C

alias lh='ls -lh'
alias eog='gpicview'
alias tmw='tmux rename-window "$(basename "$(pwd)")"'

epoch() {
    date --date @$1 +"%F %T %Z %:z"
    TZ=UTC date --date @$1 +"%F %T %Z"
}

if [[ -d /usr/local/go ]]; then
    [[ -d ~/go ]] && export GOPATH="$HOME/go" && PATH="$PATH:$GOPATH/bin"
    export GOROOT=/usr/local/go
    PATH="$PATH:$GOROOT/bin"
fi

if [[ -d ~/.cargo/bin ]]; then
    PATH="$PATH:$HOME/.cargo/bin"
    which rustc >/dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
