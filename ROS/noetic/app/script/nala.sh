#!/bin/bash

apt update

git clone https://gitlab.com/volian/nala.git .ThirdParty/nala
cd .ThirdParty/nala

echo "y" | make install
make clean

rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
