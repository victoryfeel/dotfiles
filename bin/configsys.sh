#!/usr/bin/env bash
set -e

chsh -s "$(which zsh)" && exec zsh

git config --global user.name "alex"
git config --global user.email "aliasgmail@duck.com"
git config --global init.defaultBranch main
