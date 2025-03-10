eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

alias emacs="emacsclient -c -a 'emacs'"
# alias ls="ls --color=tty"
alias ls="eza --icons=always"
alias enw="emacs -nw"
alias n="nvim"
alias cl="clear"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zhistory
HISTDUP=erase
setopt sharehistory

DISABLE_AUTO_TITLE="true"
export EDITOR=nvim

autoload -U colors && colors

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

export PATH=/home/ifmund/.local/bin:/home/ifmund/.config/emacs/bin:/home/ifmund/.ghcup/hls/2.9.0.1/bin:/home/ifmund/.nix-profile/bin:$PATH

source ~/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f "/home/ifmund/.ghcup/env" ] && . "/home/ifmund/.ghcup/env" # ghcup-env
