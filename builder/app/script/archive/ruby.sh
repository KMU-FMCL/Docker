#!/bin/bash
set -e

git clone--recursive --depth=1 https://github.com/rbenv/ruby-build.git $HOME/.ruby-build
cd $HOME/.ruby-build

PREFIX=/usr/local $HOME/.ruby-build/install.sh

ruby-build --list
ruby-build 3.3.7 $HOME/.ruby

export PATH=$HOME/.ruby/bin:$PATH

gem update --system
gem install neovim
