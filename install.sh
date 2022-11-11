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

for d in $(ls -d */ | cut -f1 -d '/');
do
  ( stow "$d"  )
done
