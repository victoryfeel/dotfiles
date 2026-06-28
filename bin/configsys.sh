#!/usr/bin/env bash
set -e

chsh -s "$(which zsh)" && exec zsh
mkdir -p "$HOME/ongo"
mkdir -p "$HOME/learn"
mkdir -p "$HOME/tmp"

git config --global user.name "alex"
git config --global user.email "aliasgmail@duck.com"
git config --global init.defaultBranch main
