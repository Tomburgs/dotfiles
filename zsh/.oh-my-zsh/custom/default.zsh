export FZF_DEFAULT_COMMAND='ag -i -g ""'
export BAT_THEME='Monokai Extended'
export SBT_OPTS="-Xss4M -Xms256M -Xmx4G -XX:+HeapDumpOnOutOfMemoryError"
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export GOPRIVATE=github.com/ReadShape/*

export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin:$HOME/.cargo/bin:/usr/local/sbin:/opt/homebrew/bin:$HOME/.local/bin:/usr/local/opt/libpq/bin:/usr/local/opt/ruby/bin

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

alias vim='nvim'
alias ll='ls -lstar'
alias ls='ls -aG'

# ESP-32 Development
alias get_idf='. $HOME/esp/esp-idf/export.sh'

eval "$(starship init zsh)"
