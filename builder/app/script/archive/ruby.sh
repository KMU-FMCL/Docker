#!/bin/bash
set -e

git clone -b v0.9.4 --recursive --depth=1 https://github.com/postmodern/ruby-install.git $HOME/.ruby-install
cd $HOME/.ruby-install && make install

export MAKEFLAGS="-j$(nproc)"

ruby-install --update
ruby-install --install-dir $HOME/.ruby ruby 3.3.6

export PATH=$HOME/.ruby/bin:$PATH

gem update --system 3.6.3
gem install neovim
