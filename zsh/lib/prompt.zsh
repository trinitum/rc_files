setopt PROMPT_SUBST
local ret_status="%(?:%F{green}✔ :%F{red}✖ )"

function git_info() {
    local REF INDEX STATUS
    STATUS="%F{green}("
    REF=$(command git symbolic-ref HEAD 2> /dev/null) || \
        REF=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    STATUS="$STATUS${REF#refs/heads/}"
    INDEX=$(command git status --porcelain -b 2> /dev/null) || return 0
    if $(echo "$INDEX" | command grep -E '^\?' &> /dev/null); then
        STATUS="${STATUS}%F{red}%%"
    fi
    if $(echo "$INDEX" | command grep -E '^.[A-Z]' &> /dev/null); then
        STATUS="${STATUS}%F{red}*"
    fi
    if $(echo "$INDEX" | command grep -E '^[A-Z]' &> /dev/null); then
        STATUS="${STATUS}%F{green}+"
    fi
    if $(command git rev-parse --verify refs/stash &> /dev/null); then
        STATUS="${STATUS}%F{yellow}$"
    fi
    if $(echo "$INDEX" | command grep -E '^##.*behind[[:space:]][[:digit:]]' &> /dev/null); then
        STATUS="$STATUS%F{yellow}<"
    fi
    if $(echo "$INDEX" | command grep -E '^##.*ahead[[:space:]][[:digit:]]' &> /dev/null); then
        STATUS="$STATUS%F{yellow}>"
    fi
    echo "$STATUS%F{green})%f "
}

PROMPT='%B${ret_status}%F{yellow}%n%F{cyan}@%m:%F{white}%d
%F{cyan}%* $(git_info)%F{white}%%%f%b '
