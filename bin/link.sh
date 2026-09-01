#!/usr/bin/env bash
set -e

DOTFILES="$HOME/alexmak/dotfiles"

echo "creating symbolic links..."
#==============================
#=====  general  ======
#==============================
mkdir -p "$HOME/.local/share"
ln -sfn "$DOTFILES/fonts" "$HOME/.local/share/fonts"
ln -sfn "$DOTFILES/scripts" "$HOME/.config/scripts"
ln -sfn "$DOTFILES/fastfetch" "$HOME/.config/fastfetch"
# zsh
mkdir -p "$HOME/.config/zsh"
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/zimrc" "$HOME/.config/zsh/.zimrc"
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
# htop
mkdir -p "$HOME/.config/htop"
ln -sf "$DOTFILES/htop/htoprc" "$HOME/.config/htop/htoprc"

#=============================
#=====  the four mains  ======
#=============================
# yazi-nvim
ln -sfn "$DOTFILES/yazi" "$HOME/.config/yazi"
ln -sfn "$DOTFILES/nvim" "$HOME/.config/nvim"
# tmux
mkdir -p "$HOME/.config/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
# lazygit-lazydocker
mkdir -p "$HOME/.config/lazygit"
ln -sf "$DOTFILES/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
mkdir -p "$HOME/.config/lazydocker"
ln -sf "$DOTFILES/lazydocker/config.yml" "$HOME/.config/lazydocker/config.yml"

#=============================
#=====  llm config  ======
#=============================
mkdir -p "$HOME/.gemini/antigravity-cli/"
ln -sf "$DOTFILES/llmconfig/gemini-settings.json" "$HOME/.gemini/antigravity-cli/settings.json"
ln -sf "$DOTFILES/llmconfig/GEMINI.md" "$HOME/.gemini/GEMINI.md"

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
