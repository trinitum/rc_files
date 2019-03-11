bindkey -e

bindkey '\ee' emacs-forward-word
bindkey '\ek' up-line
bindkey '\ej' down-line

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
