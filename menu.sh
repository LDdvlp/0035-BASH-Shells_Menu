#!/usr/bin/env bash

ROOT_DIR="$(
  cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 || exit
  pwd
)"

exec "$ROOT_DIR/bin/menu.sh" "$@"
