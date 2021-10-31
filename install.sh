# Got to install packer 🤌
PACKER_DIR=~/.local/share/nvim/site/pack/packer/start/packer.nvim

if [ ! -d $PACKER_DIR ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    $PACKER_DIR
fi

for d in $(ls -d */ | cut -f1 -d '/');
do
  ( stow "$d"  )
done
