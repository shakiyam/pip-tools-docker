#!/bin/bash
set -Eeu -o pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
readonly SCRIPT_DIR
# shellcheck disable=SC1091
. "$SCRIPT_DIR"/tools/colored_echo.sh
# shellcheck disable=SC1091
. "$SCRIPT_DIR"/tools/container_engine.sh

CONTAINER_ENGINE=$(detect_container_engine)
readonly CONTAINER_ENGINE

IMAGE_NAME=ghcr.io/shakiyam/pip-tools
readonly IMAGE_NAME

if [[ $CONTAINER_ENGINE == docker ]]; then
  ENGINE_OPTS=(-u "$(id -u):$(id -g)")
else
  ENGINE_OPTS=(--security-opt label=disable)
fi
readonly ENGINE_OPTS

WORK_DIR=$(mktemp -d)
readonly WORK_DIR
trap 'rm -rf "$WORK_DIR"' EXIT

echo six >"$WORK_DIR"/requirements.in

if ! $CONTAINER_ENGINE container run \
  --name "test_pip_tools_$(uuidgen | head -c8)" \
  --rm \
  --pull=never \
  "${ENGINE_OPTS[@]}" \
  -e HOME=/tmp \
  -v "$WORK_DIR":/work \
  -w /work \
  "$IMAGE_NAME" pip-compile --strip-extras requirements.in; then
  echo_error 'Test failed: pip-compile exited with a non-zero status.'
  exit 1
fi

if [[ ! -f "$WORK_DIR"/requirements.txt ]]; then
  echo_error 'Test failed: requirements.txt was not generated.'
  exit 1
fi

if ! grep -q '^six==' "$WORK_DIR"/requirements.txt; then
  echo_error 'Test failed: requirements.txt does not contain a pinned six.'
  cat "$WORK_DIR"/requirements.txt
  exit 1
fi

echo_success 'Test passed: pip-compile resolved and pinned six successfully.'
