#!/usr/bin/env bash
set -e

echo "installing packages..."

#==========================
#========  Linux  =========
#==========================
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

#========================
#========  Mac  =========
#========================
if [ "$(uname -s)" = "Darwin" ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install --cask orbstack
	brew install --cask visual-studio-code
	brew install --cask dbeaver-community
	brew install --cask netnewswire
	brew install --cask cryptomator
	brew install --cask freefilesync
	#brew install --cask alfred
	brew install --cask anki
	brew install --cask calibre
	brew install --cask obsidian
	brew install --cask google-drive
	brew install --cask brave-browser
	#brew install --cask helium-browser
	#brew install --cask pdf-expert

	echo "Manual install with following links:"
	echo "alacritty: https://alacritty.org/"
	echo "mpv player: https://github.com/mpv-player/mpv/releases"
	echo "v2rayn: https://github.com/2dust/v2rayN/releases"
	echo "qBittorent: https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases"
	echo "cracked app links:"
	echo "alfred: https://www.minorpatch.com/apps/alfred-powerpack.html"
	echo "pdf expert: https://www.minorpatch.com/apps/pdf-expert.html"

fi

echo "done!"
