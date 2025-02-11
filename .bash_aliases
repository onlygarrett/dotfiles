alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias update='sudo apt-get update && sudo apt-get upgrade'

alias apt-history='zgrep Install: /var/log/apt/history.log* |sed "s,:amd64 , ,g;s,.*Install: ,,;s/, automatic/AUTO/g;s/, /\n/g" | grep -v AUTO |tac'
