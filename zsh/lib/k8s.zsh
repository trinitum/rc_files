if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
    alias k=kubectl
    compdef __start_kubectl k
fi

if command kubeadm &>/dev/null; then
    source <(kubeadm completion zsh)
fi
