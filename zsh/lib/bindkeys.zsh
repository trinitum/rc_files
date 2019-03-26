bindkey -e

bindkey '\ee' emacs-forward-word
bindkey '\ek' up-line
bindkey '\ej' down-line

bindkey '\eb' vi-backward-word
bindkey '\ef' vi-forward-word
bindkey '\e\C-w' vi-backward-kill-word
bindkey '\e\C-?' vi-backward-kill-word

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
