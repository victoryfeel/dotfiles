#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"

echo "creating directories..."

mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.config/lazygit"
mkdir -p "$HOME/.config/nvim/lua/alexmak/core"
mkdir -p "$HOME/.config/nvim/lua/alexmak/plugins"
mkdir -p "$HOME/.config/scripts"
mkdir -p "$HOME/.config/tmux"
mkdir -p "$HOME/.config/yazi"
mkdir -p "$HOME/.config/zsh"
mkdir -p "$HOME/.local/share/fonts"

echo "creating symbolic links..."

# alacritty
ln -sf "$DOTFILES/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
# zsh
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/zimrc" "$HOME/.config/zsh/.zimrc"
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
# fonts
ln -sf "$DOTFILES/local/share/fonts/"* "$HOME/.local/share/fonts/"
# scripts
ln -sf "$DOTFILES/scripts/executable_tmux_session_switch.sh" "$HOME/.config/scripts/executable_tmux_session_switch.sh"

# lazygit
ln -sf "$DOTFILES/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
# nvim
ln -sf "$DOTFILES/nvim/init.lua" "$HOME/.config/nvim/init.lua"
ln -sf "$DOTFILES/nvim-pack-lock.json" "$HOME/.config/nvim/nvim-pack-lock.json"
ln -sf "$DOTFILES/nvim/lua/alexmak/core/colorscheme.lua" "$HOME/.config/nvim/lua/alexmak/core/colorscheme.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/core/keymaps.lua" "$HOME/.config/nvim/lua/alexmak/core/keymaps.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/core/options.lua" "$HOME/.config/nvim/lua/alexmak/core/options.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/fzf-lua.lua" "$HOME/.config/nvim/lua/alexmak/plugins/fzf-lua.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/gitsigns.lua" "$HOME/.config/nvim/lua/alexmak/plugins/gitsigns.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/lsp.lua" "$HOME/.config/nvim/lua/alexmak/plugins/lsp.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/lualine.lua" "$HOME/.config/nvim/lua/alexmak/plugins/lualine.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/mason.lua" "$HOME/.config/nvim/lua/alexmak/plugins/mason.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/mini.lua" "$HOME/.config/nvim/lua/alexmak/plugins/mini.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/nvim-tree.lua" "$HOME/.config/nvim/lua/alexmak/plugins/nvim-tree.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/treesitter.lua" "$HOME/.config/nvim/lua/alexmak/plugins/treesitter.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/web-devicons.lua" "$HOME/.config/nvim/lua/alexmak/plugins/web-devicons.lua"
# tmux
ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
# yazi
ln -sf "$DOTFILES/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"
ln -sf "$DOTFILES/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"
ln -sf "$DOTFILES/yazi/vfs.toml" "$HOME/.config/yazi/vfs.toml"
ln -sf "$DOTFILES/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"

echo "done!"
