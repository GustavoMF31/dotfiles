#!/bin/bash

temp_dir=$(mktemp -d)

# Get dotfiles
pushd ${temp_dir}
git clone https://github.com/GustavoMF31/dotfiles.git
cp dotfiles/.vimrc ~/.vimrc
rm -Rf ${temp_dir}
popd

# Get Coqtail from https://github.com/whonore/Coqtail
# (As a vim package, as specified in the README)
mkdir -p ~/.vim/pack/coq/start
git clone https://github.com/whonore/Coqtail.git ~/.vim/pack/coq/start/Coqtail
vim +helptags\ ~/.vim/pack/coq/start/Coqtail/doc +q
