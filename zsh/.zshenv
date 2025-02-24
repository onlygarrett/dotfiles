. "$HOME/.cargo/env"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
# lspserver
export PATH=$PATH:$HOME/.config/lsp/lua-language-server/bin/lua_language_server
export PATH=$PATH:$HOME/.config/lsp/lua-language-server/bin/
export HISTFILE="$HOME/.zsh_history"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

