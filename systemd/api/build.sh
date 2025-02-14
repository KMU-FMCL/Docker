#!/bin/bash

docker buildx build --platform linux/amd64 -t kmu-fmcl/systemd-api:fastapi-v13.3.0-12.4.1-ubuntu22.04 --load .
