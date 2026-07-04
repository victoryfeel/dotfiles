#!/usr/bin/env bash
set -e

echo "config system..."

if [ "$(uname -s)" = "Darwin" ]; then
	#========================
	#========  Mac  =========
	#========================
	chsh -s "$(which zsh)"
	mkdir -p "$HOME/ongo"
	mkdir -p "$HOME/learn"
	mkdir -p "$HOME/tmp"

	git config --global user.name "alex"
	git config --global user.email "aliasgmail@duck.com"
	git config --global init.defaultBranch main

else
	#==========================
	#========  Linux  =========
	#==========================
	mkdir -p "$HOME/tmp"

fi

echo "done!"
