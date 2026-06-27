#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

echo "creating directories..."

# create directory for single dotfile
mkdir -p "$HOME/.config/zsh"
mkdir -p "$HOME/.local/share/fonts"

echo "creating symbolic links..."

# link single dotfile
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/zimrc" "$HOME/.config/zsh/.zimrc"
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/local/share/fonts/"* "$HOME/.local/share/fonts/"

# ln -sfn 只能替换 symlink，无法替换真实目录，所以先清理旧目录
config_dirs=(alacritty lazygit nvim scripts tmux yazi)
for dir in "${config_dirs[@]}"; do
	target="$HOME/.config/$dir"
	# 如果是真实目录（非 symlink），先删除
	if [ -d "$target" ] && [ ! -L "$target" ]; then
		rm -rf "$target"
	fi
	ln -sfn "$DOTFILES/$dir" "$target"
done

echo "done!"
