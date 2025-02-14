#!/bin/bash
sed -e

cd /app/script/archive

./gcc.sh
./rustup.sh
./go.sh
./node.sh
./ruby.sh
./unix_modern_command.sh
./zsh.sh

./tar.sh
./nvidia_video_codec_sdk.sh
