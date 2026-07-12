#!/usr/bin/env bash
set -e

DOTFILES="$HOME/alexmak/dotfiles"

echo "creating symbolic links..."
#============================
#=====  zsh config  ======
#============================
# fonts
mkdir -p "$HOME/.local/share/fonts"
ln -sf "$DOTFILES/local/share/fonts/JetBrainsMonoNerdFontMono-Regular.ttf" "$HOME/.local/share/fonts/JetBrainsMonoNerdFontMono-Regular.ttf"
ln -sf "$DOTFILES/local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf"
# scripts
mkdir -p "$HOME/.config/scripts"
ln -sf "$DOTFILES/scripts/executable_tmux_session_switch.sh" "$HOME/.config/scripts/executable_tmux_session_switch.sh"
# zsh
mkdir -p "$HOME/.config/zsh"
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
ln -sf "$DOTFILES/zsh/zimrc" "$HOME/.config/zsh/.zimrc"
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"

#=============================
#=====  the four mains  ======
#=============================
# nvim
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/nvim/lua/alexmak/core"
mkdir -p "$HOME/.config/nvim/lua/alexmak/plugins"
ln -sf "$DOTFILES/nvim/init.lua" "$HOME/.config/nvim/init.lua"
ln -sf "$DOTFILES/nvim/nvim-pack-lock.json" "$HOME/.config/nvim/nvim-pack-lock.json"
ln -sf "$DOTFILES/nvim/lua/alexmak/core/colorscheme.lua" "$HOME/.config/nvim/lua/alexmak/core/colorscheme.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/core/keymaps.lua" "$HOME/.config/nvim/lua/alexmak/core/keymaps.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/core/options.lua" "$HOME/.config/nvim/lua/alexmak/core/options.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/fzf-lua.lua" "$HOME/.config/nvim/lua/alexmak/plugins/fzf-lua.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/gitsigns.lua" "$HOME/.config/nvim/lua/alexmak/plugins/gitsigns.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/lsp.lua" "$HOME/.config/nvim/lua/alexmak/plugins/lsp.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/lualine.lua" "$HOME/.config/nvim/lua/alexmak/plugins/lualine.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/nvim-web-devicons.lua" "$HOME/.config/nvim/lua/alexmak/plugins/nvim-web-devicons.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/mason.lua" "$HOME/.config/nvim/lua/alexmak/plugins/mason.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/mini.lua" "$HOME/.config/nvim/lua/alexmak/plugins/mini.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/treesitter.lua" "$HOME/.config/nvim/lua/alexmak/plugins/treesitter.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/lazygit.lua" "$HOME/.config/nvim/lua/alexmak/plugins/lazygit.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/yazi.lua" "$HOME/.config/nvim/lua/alexmak/plugins/yazi.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/markdown.lua" "$HOME/.config/nvim/lua/alexmak/plugins/markdown.lua"
ln -sf "$DOTFILES/nvim/lua/alexmak/plugins/outline.lua" "$HOME/.config/nvim/lua/alexmak/plugins/outline.lua"
# tmux
mkdir -p "$HOME/.config/tmux"
ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
# yazi
mkdir -p "$HOME/.config/yazi"
ln -sf "$DOTFILES/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"
ln -sf "$DOTFILES/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"
ln -sf "$DOTFILES/yazi/vfs.toml" "$HOME/.config/yazi/vfs.toml"
ln -sf "$DOTFILES/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
# lazygit
mkdir -p "$HOME/.config/lazygit"
ln -sf "$DOTFILES/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

#======================================
#=====  gui tools config for mac  ======
#======================================
if [ "$(uname -s)" = "Darwin" ]; then
	# alacritty
	mkdir -p "$HOME/.config/alacritty"
	ln -sf "$DOTFILES/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
	# mpv
	ln -sfn "$DOTFILES/mpv/portable_config" "$HOME/.config/mpv"
fi

echo "done!"
