#!/usr/bin/zsh

IMAGE="taehun3446/ros:noetic"

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 { --load | --push | --rm }"
  exit 1
fi

case "$1" in
  --load)
    echo "Building Docker image and loading it locally..."
    docker buildx build -t ${IMAGE} --load .
    ;;
  --push)
    echo "Building Docker image for linux/amd64, arm64 and pushing it..."
    docker buildx build -t ${IMAGE} --push .
    ;;
  --rm)
    echo "Removing Docker image ${IAMGE}..."
    docker image rm ${IMAGE}
    ;;
  *)
    echo "Invalid option: $1"
    echo "Usage: $0 { --load | --push | --rm }"
    exit 1
    ;;
esac
