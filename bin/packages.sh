#!/usr/bin/env bash
set -e

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm base-devel curl git zip unzip trash-cli tree
sudo pacman -S --needed --noconfirm zsh fzf ripgrep fd the_silver_searcher fastfetch mandoc
sudo pacman -S --needed --noconfirm neovim yazi tmux lazygit git-delta
sudo pacman -S --needed --noconfirm htop cmake make ninja gdb clang llvm lldb bear podman

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

command -v yay >/dev/null || (
	mkdir -p "${HOME}/tmp" &&
		cd "${HOME}/tmp" &&
		rm -rf yay &&
		git clone https://aur.archlinux.org/yay.git &&
		cd yay &&
		makepkg -sic --noconfirm &&
		cd "${HOME}" &&
		rm -rf "${HOME}/tmp/yay"
)
