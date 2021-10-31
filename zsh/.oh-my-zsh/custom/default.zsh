export FZF_DEFAULT_COMMAND='ag -i -g ""'
export BAT_THEME='Monokai Extended'

export PATH=$PATH:$HOME/go/bin:$(yarn global bin)

alias vim='nvim'
alias ll='ls -lstar'
alias ls='ls -aG'

eval "$(starship init zsh)"
