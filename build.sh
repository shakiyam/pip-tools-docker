#!/bin/bash
set -eu -o pipefail

IMAGE_NAME='shakiyam/pip-tools'
readonly IMAGE_NAME
DOCKER=$(command -v podman || command -v docker)
readonly DOCKER
CURRENT_IMAGE="$($DOCKER image ls -q $IMAGE_NAME:latest)"
readonly CURRENT_IMAGE
$DOCKER image build -t "$IMAGE_NAME" "$(dirname "$0")"
LATEST_IMAGE="$($DOCKER image ls -q $IMAGE_NAME:latest)"
readonly LATEST_IMAGE
if [[ "$CURRENT_IMAGE" != "$LATEST_IMAGE" ]]; then
  $DOCKER image tag $IMAGE_NAME:latest $IMAGE_NAME:"$(date +%Y%m%d%H%S)"
fi
