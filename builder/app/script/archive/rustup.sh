#!/bin/bash
set -e

curl https://sh.rustup.rs -sSf | sh -s -- -y && . $HOME/.cargo/env
rustup update stable

packages=(
  tealdeer
  choose
  du-dust
  eza
  fd-find
  procs
  ripgrep
  sd
  bottom
  bat
  broot
  hyperfine
  tree-sitter-cli
  zellij
  yazi-fm
  yazi-cli
)

cargo install cargo-quickinstall cargo-binstall

for pkg in "${packages[@]}"; do
  cargo quickinstall "$pkg"
done

# zfunc_dir="$HOME/.zfunc" && mkdir -p "$zfunc_dir"

# rustup completions zsh > "$zfunc_dir/_rustup" && rustup completions zsh cargo > "$zfunc_dir/_cargo"
