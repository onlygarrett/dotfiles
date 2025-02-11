. "$HOME/.cargo/env"
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
# lspserver
export PATH=$PATH:$HOME/.config/lsp/lua-language-server/bin/lua_language_server
export PATH=$PATH:$HOME/.config/lsp/lua-language-server/bin/
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file

