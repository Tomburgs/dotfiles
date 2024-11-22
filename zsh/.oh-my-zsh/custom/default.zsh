export FZF_DEFAULT_COMMAND='ag -i -g ""'
export BAT_THEME='Monokai Extended'
export SBT_OPTS="-Xss4M -Xms256M -Xmx4G -XX:+HeapDumpOnOutOfMemoryError"
export USE_GKE_GCLOUD_AUTH_PLUGIN=true
export GOPRIVATE=github.com/ReadShape/*

export PATH=$PATH:$HOME/go/bin:/usr/local/go/bin:\
$HOME/.cargo/bin:\
/usr/local/sbin:\
/opt/homebrew/bin:\
$HOME/.local/bin:/usr/local/opt/libpq/bin:/usr/local/opt/ruby/bin:\
$HOME/fvm/default/bin:\
$HOME/Library/Android/sdk/emulator

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

alias vim='nvim'
alias ll='ls -lstar'
alias ls='ls -aG'

# ESP-32 Development
alias get_idf='. $HOME/esp/esp-idf/export.sh'

eval "$(starship init zsh)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

eval "$(atuin init zsh --disable-up-arrow)"

alias sjn='docker run -it --rm -p 10000:8888 -v "${PWD}":~/jupyter quay.io/jupyter/datascience-notebook:2024-03-14'
