fish_add_path ~/.local/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    cd ~
end

alias ls='lsd --icon=auto -la --group-directories-first -t'
alias h='herdr'
alias v='nvim'
alias c='claude'

zoxide init fish --cmd z | source

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    set cwd (cat -- "$tmp")
    if test -n "$cwd" -a "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
