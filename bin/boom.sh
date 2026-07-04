#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

bash "$SCRIPT_DIR/packages.sh"
bash "$SCRIPT_DIR/configsys.sh"
bash "$SCRIPT_DIR/link.sh"

exec zsh
