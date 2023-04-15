#!/bin/bash

temp_dir=$(mktemp -d)

pushd ${temp_dir}
git clone https://github.com/GustavoMF31/dotfiles.git
cp dotfiles/.vimrc ~/.vimrc
rm -Rf ${temp_dir}
popd
