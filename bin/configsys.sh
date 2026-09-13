#!/usr/bin/env bash
set -e

echo "[configsys.sh] Config system..."

if [ "$SHELL" != "$(which zsh)" ]; then
  sudo chsh -s "$(which zsh)" "$USER" || true
fi
mkdir -p "$HOME/alexmak/learn"
mkdir -p "$HOME/alexmak/ongo"
mkdir -p "$HOME/tmp"

git config --global user.name "Alex Mak"
git config --global user.email "113433667+victoryfeel@users.noreply.github.com"
git config --global init.defaultBranch main
git config --global core.fsync all
git config --global core.fsyncMethod fsync

# systemctl --user enable --now podman.socket

echo "[configsys.sh] Finished."
