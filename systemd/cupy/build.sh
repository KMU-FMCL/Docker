#!/bin/bash

docker buildx build --platform linux/amd64 -t kmu-fmcl/systemd-cupy:v13.3.0-12.4.1-cudnn-devel-ubuntu22.04 --load .
