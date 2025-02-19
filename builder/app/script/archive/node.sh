#!/bin/bash
set -e

if [[ $(id -u) -eq 0 ]]; then
  sudo_cmd=""
else
  sudo_cmd="sudo"
fi

git clone -b v5.3.22 --recursive --depth=1 https://github.com/nodenv/node-build.git $HOME/.node-build

if ! PREFIX=/usr/local "$HOME/.node-build/install.sh" &> /dev/null; then
  $sudo_cmd PREFIX=/usr/local "$HOME/.node-build/install.sh"
else
  echo "Installation Complete"
fi

node-build 22.12.0 $HOME/.node

export PATH=$HOME/.node/bin:$PATH

npm install -g npm@latest
npm install -g neovim
