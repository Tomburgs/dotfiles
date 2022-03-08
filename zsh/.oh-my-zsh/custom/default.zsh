export FZF_DEFAULT_COMMAND='ag -i -g ""'
export BAT_THEME='Monokai Extended'
export SBT_OPTS="-Xss4M -Xms256M -Xmx4G -XX:+HeapDumpOnOutOfMemoryError"

export PATH=$PATH:$HOME/go/bin

alias vim='nvim'
alias ll='ls -lstar'
alias ls='ls -aG'

eval "$(starship init zsh)"
