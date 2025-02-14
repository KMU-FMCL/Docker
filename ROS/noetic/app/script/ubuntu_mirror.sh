#!/bin/bash

CONFIG_FILE="/etc/apt/sources.list"

ARCHITECTURE=$(uname -m)

case "$ARCHITECTURE" in 
  x86_64)
    MIRROR_SITE="https://ftp.udx.icscoe.jp/Linux"
    ;;
  aarch64)
    MIRROR_SITE="https://ftp.lanet.kr"
    ;;
esac

if [ -f "$CONFIG_FILE" ]; then
  sudo sed -i "s|http://archive.ubuntu.com|$MIRROR_SITE|g; s|http://kr.archive.ubuntu.com|$MIRROR_SITE|g; s|http://security.ubuntu.com|$MIRROR_SITE|g; s|http://ports.ubuntu.com|$MIRROR_SITE|g" /etc/apt/sources.list
fi
