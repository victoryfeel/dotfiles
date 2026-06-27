#!/usr/bin/env bash
set -e

sudo pacman -Syu --noconfirm
# ====== basic tools ======
sudo pacman -S --needed --noconfirm base-devel tldr curl git zip unzip trash-cli tree
sudo pacman -S --needed --noconfirm fzf ripgrep fd the_silver_searcher
sudo pacman -S --needed --noconfirm chezmoi fastfetch
#yay
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

# ====== dev toolchain ======
sudo pacman -S --needed --noconfirm htop cmake make ninja gdb clang llvm lldb bear podman
#claude-code
sudo pacman -S --needed --noconfirm nodejs npm
sudo npm install -g @anthropic-ai/claude-code

# ====== config git ======
sudo pacman -S --needed --noconfirm lazygit git-delta
git config --global user.name "alex"
git config --global user.email "aliasgmail@duck.com"
git config --global init.defaultBranch main
# ====== config neovim ======
sudo pacman -S --needed --noconfirm neovim
cargo install --locked tree-sitter-cli
sudo pacman -S --needed --noconfirm go lua-jsregexp luarocks
# ====== config tmux ======
sudo pacman -S --needed --noconfirm tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# ====== config yazi ======
sudo pacman -S --needed --noconfirm yazi
ya pkg add yazi-rs/plugins:full-border
ya pkg add yazi-rs/plugins:git
ya pkg add Rolv-Apneseth/starship
ya pkg add KKV9/compress
ya pkg add h-hg/yamb
ya pkg add imsi32/yatline
# ====== config zsh ======
sudo pacman -S --needed --noconfirm zsh
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
#set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
	echo "Setting zsh as default shell..."
	chsh -s "$(which zsh)"
	exec zsh
else
	echo "Your default shell is already zsh."
fi
