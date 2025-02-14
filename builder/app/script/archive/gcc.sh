#!/bin/bash
set -e

update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 200
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 200
