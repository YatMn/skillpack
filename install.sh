#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"
TARGET="${BIN_DIR}/skillpack"

mkdir -p "$BIN_DIR"
ln -sfn "${ROOT_DIR}/bin/skillpack" "$TARGET"

echo "Installed skillpack at ${TARGET}"
