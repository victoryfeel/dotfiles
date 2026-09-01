#!/usr/bin/env bash
set -e

echo "config system..."

if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)" || true
fi
mkdir -p "$HOME/alexmak/learn"
mkdir -p "$HOME/alexmak/ongo"
mkdir -p "$HOME/tmp"

git config --global user.name "Alex Mak"
git config --global user.email "113433667+victoryfeel@users.noreply.github.com"
git config --global init.defaultBranch main
# systemctl --user enable --now podman.socket

echo "done!"
