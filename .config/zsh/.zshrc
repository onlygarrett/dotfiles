if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zmodload zsh/mapfile
# ENV VARS
export CHROME_WEB_DATA="/mnt/c/Users/onlyg.GARRETT-PC/AppData/Local/Google/Chrome/User Data/Default/Web Data"

# ZSH shtuff
source ~/.zsh_functions
source ~/.zsh_aliases
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config/"

# Making alacritty aliases
export W_APPDATA=/mnt/c/Users/onlyg.GARRETT-PC/AppData
export AL_CFG=$W_APPDATA/Roaming/alacritty

ZSH_THEME="powerlevel10k/powerlevel10k"

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting autoupdate rust tmux sudo you-should-use) 

source $ZSH/oh-my-zsh.sh

DISABLE_AUTO_UPDATE=true
DISABLE_MAGIC_FUNCTIONS=true


function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}


# Example aliases
alias c="clear"
alias ..="cd .."

alias zshconfig="source ~/.zshrc"
alias ls="eza --icons --git"
alias l='eza -alg --color=always --group-directories-first --git'
alias ll='eza -alSgh --color=always --group-directories-first --icons --header --long --git'
alias lt='eza -@alT --color=always --git'
alias llt="tree"
alias lr='eza -alg --sort=modified --color=always --group-directories-first --git'
alias ide='bash ~/.config/scripts/__tmux_ide.sh'
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias python='/usr/bin/python3'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export LS_COLORS=$LS_COLORS:'ow=36:'
if [ -e /home/grumschik/.nix-profile/etc/profile.d/nix.sh ]; then . /home/grumschik/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export FPATH="/home/grumschik/.oh-my-zsh/custom/plugins/eza/completions/zsh:$FPATH"
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi
export BROWSER="firefox"

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Created by `pipx` on 2024-05-05 02:14:42
export PATH="$PATH:/home/grumschik/.local/bin"

# fzf
export FZF_DEFAULT_COMMAND='fd --type file --color=always --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# fnm
FNM_PATH="/home/grumschik/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="/home/grumschik/.local/share/fnm:$PATH"
    eval "`fnm env`"
fi
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(zoxide init zsh)"


