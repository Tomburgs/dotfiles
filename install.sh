DOTFILE_DIR=$(pwd)

# Got to install packer 🤌
PACKER_DIR=~/.local/share/nvim/site/pack/packer/start/packer.nvim

if [ ! -d $PACKER_DIR ]; then
  echo "No packer, creating... ⏳\n"
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    $PACKER_DIR
fi

# Got to install tpm 🤌
TPM_DIR=~/.tmux/plugins/tpm

if [ ! -d $TPM_DIR ]; then
  echo "No tpm, creating... ⏳\n"
  git clone https://github.com/tmux-plugins/tpm\
    $TPM_DIR
fi

# Got to install rvm 🤙

RVM_DIR=~/.rvm/src

if [ ! -d $RVM_DIR ]; then
  mkdir -p $RVM_DIR && cd $RVM_DIR && rm -rf ./rvm && \
  git clone --depth 1 https://github.com/rvm/rvm.git && \
  cd rvm && ./install && cd $DOTFILE_DIR
fi

for d in $(ls -d */ | cut -f1 -d '/');
do
  ( stow "$d"  )
done
