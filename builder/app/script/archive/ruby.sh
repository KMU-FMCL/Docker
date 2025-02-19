#!/bin/bash
set -e

packages=(
  git
  autoconf
  patch
  build-essential
  libssl-dev
  libyaml-dev
  libreadline6-dev
  zlib1g-dev
  libgmp-dev
  libncurses5-dev
  libffi-dev
  libgdbm6
  libgdbm-dev
  libdb-dev
  uuid-dev
)

if [[ $(id -u) -eq 0 ]]; then
  sudo_cmd=""
else
  sudo_cmd="sudo"
fi

if command -v nala &> /dev/null; then
  packages_manager="nala"
else
  packages_manager="apt"
fi

for pkg in "${packages[@]}"; do
  if ! dpkg -s "$pkg" &> /dev/null; then
    $sudo_cmd $packages_manager update
    $sudo_cmd $packages_manager install -y "$pkg"
  else
    echo "Already $pkg package"
  fi
done

git clone --recursive --depth=1 https://github.com/rbenv/ruby-build.git $HOME/.ruby-build
cd $HOME/.ruby-build

if ! PREFIX=/usr/local "$HOME/.ruby-build/install.sh" &> /dev/null; then
 $sudo_cmd PREFIX=/usr/local $HOME/.ruby-build/install.sh
else
  echo "Installation Complete"
fi

ruby-build --list
ruby-build 3.3.7 $HOME/.ruby

export PATH=$HOME/.ruby/bin:$PATH

gem update --system
gem install neovim
