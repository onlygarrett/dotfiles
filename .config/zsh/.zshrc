export XDG_CONFIG_HOME=$HOME/.config
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to python
export PYTHONPATH='/usr/bin/python'
# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

ZSH_THEME="agnoster"
export BAT_THEME=tokyonight_night

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions aliases fzf gh history zsh-history-substring-search nvm npm node tmux rust web-search)

source $ZSH/oh-my-zsh.sh

# aliases
alias c="clear"
alias grep="grep --color=auto" 
alias diff="diff --color=auto" 
alias rm="rm -r"
alias mv="mv -i"
alias v="nvim"
alias ls="eza --icons=always --git --color=always --long --no-filesize --no-time --no-user --no-permissions"
alias l='eza --color=always --long --git --no-filesize --icons=always --no-time --no-permissions --group-directories-first'
alias update="sudo apt-get update && sudo apt-get upgrade"
alias ll='eza -aliSgh --color=always --group-directories-first --icons --header --long --git'
alias lt='eza -@alT --color=always --git'
alias llt="eza --oneline --icons --git-ignore"
alias lr='eza -alg --sort=modified --color=always --group-directories-first --git'
alias con="cd ~/.config"
alias apt-hist='zgrep Install: /var/log/apt/history.log* |sed "s,:amd64 , ,g;s,.*Install: ,,;s/, automatic/AUTO/g;s/, /\n/g" | grep -v AUTO |tac'
alias cd="z"
alias wbddg="web_search duckduckgo"
alias sz="source ~/.config/zsh/.zshrc"
alias ide="bash ~/repos/term_scripts/tmuxScripts.sh"

# neofetch
neofetch --config $XDG_CONFIG_HOME/neofetch/asdf/config3.conf

# eza
export FPATH="~/personal/eza/completions/zsh:$FPATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="$PATH:/home/jee/.local/bin"
export PATH="$PATH:/home/jee/personal/meson/"

# fzf fd
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
	fd --hidden --exclude .git . "$1"
}
_fzf_compgen_dir() {
	fd --type=d --hidden --exclude .git . "$1"
}

# fzf

fg="#CBE0F0"
bg="#011628"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"


# fzf preview
source ~/fzf-git.sh/fzf-git.sh 
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${purple},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
	local command=$1
	shift

	case "$command" in
		cd)		          fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
		export|unset)	  fzf --preview "eval 'echo \$' {}"	"$@" ;;
		ssh)		        fzf --preview 'dig {}'			"$@" ;;
		*)		          fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "$@" ;;
	esac
}

# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# zoxide alias
eval "$(zoxide init zsh)"


source /home/jee/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
prompt_context() {}

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi
