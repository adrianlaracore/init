fish_add_path ~/.local/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    cd ~/desktop
end

alias ls='lsd --icon=auto -la --group-directories-first -t'
alias h='herdr'
alias v='nvim'
alias c='claude'
alias gg='lazygit'
alias cz='chezmoi'

zoxide init fish --cmd z | source
