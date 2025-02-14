#!/bin/bash
set -e

git clone -b v5.3.22 --recursive --depth=1 https://github.com/nodenv/node-build.git $HOME/.node-build

PREFIX=/usr/local $HOME/.node-build/install.sh
node-build 22.12.0 $HOME/.node

export PATH=$HOME/.node/bin:$PATH

npm install -g npm@latest
npm install -g neovim
