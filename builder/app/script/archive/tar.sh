#!/bin/bash
set -e

tar -czvf /app/setup.tar.gz \
    $HOME/.cargo/bin \
    $HOME/.go/bin \
    $HOME/.node \
    $HOME/.ruby \
    $HOME/.oh-my-zsh \
    $HOME/.zfunc \
    $HOME/.config \
    $HOME/.local \
    $HOME/.fzf/bin 
