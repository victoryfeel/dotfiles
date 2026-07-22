#!/usr/bin/env bash
set -e

DOTFILES="$HOME/alexmak/dotfiles"

echo "creating symbolic links..."
#==============================
#=====  zsh-font-script  ======
#==============================
ln -sfn "$DOTFILES/fonts" "$HOME/.local/share/fonts"
ln -sfn "$DOTFILES/scripts" "$HOME/.config/scripts"
# zsh
mkdir -p "$HOME/.config/zsh"
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/zimrc" "$HOME/.config/zsh/.zimrc"
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"

#=============================
#=====  the four mains  ======
#=============================
# yazi-nvim
ln -sfn "$DOTFILES/yazi" "$HOME/.config/yazi"
ln -sfn "$DOTFILES/nvim" "$HOME/.config/nvim"
# tmux
mkdir -p "$HOME/.config/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
# lazygit
mkdir -p "$HOME/.config/lazygit"
ln -sf "$DOTFILES/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

#=============================
#=====  llm config  ======
#=============================
mkdir -p "$HOME/.gemini/antigravity-cli/"
ln -sf "$DOTFILES/llmconfig/gemini-settings.json" "$HOME/.gemini/antigravity-cli/settings.json"


#=======================================
#=====  gui tools config for mac  ======
#=======================================
if [ "$(uname -s)" = "Darwin" ]; then
	# alacritty
	# mkdir -p "$HOME/.config/alacritty"
	# ln -sf "$DOTFILES/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

	# ghostty

	# mpv
	ln -sfn "$DOTFILES/mpv/portable_config" "$HOME/.config/mpv"
fi

echo "done!"
