set -x PATH ~/bin $PATH

if test -f /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

if type -q fzf
    fzf --fish | source
end

if type -q fnm
    fnm env --use-on-cd --shell fish | source
end

if type -q bat
    alias cat=bat
end

if type -q nvim
    set -x EDITOR nvim
    alias vim=nvim
end

if type -q eza
    alias l="eza --icons"
    alias ls="l"
    alias la="l -a"
    alias ll="l -l"
    alias lal="l -al"
    alias lt="l -T"
end

# Disable the MOTD
set fish_greeting
