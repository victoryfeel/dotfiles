#!/usr/bin/env bash
set -e

echo "installing packages..."

if [ "$(uname -s)" = "Darwin" ]; then
  #========================
  #========  Mac  =========
  #========================
  eval "$(/opt/homebrew/bin/brew shellenv)"

  brew install git git-delta fzf fd ripgrep trash-cli
  brew install mandoc htop fastfetch onefetch
  brew install lazygit neovim yazi tmux
  brew install imagemagick
  brew install --cask antigravity-cli
  brew install --cask ghostty orbstack dbeaver-community
  brew install --cask freefilesync google-drive cryptomator
  brew install --cask anki calibre obsidian netnewswire
  brew install --cask helium-browser

  echo "Manual install with following links:"
  echo "mpv player: https://github.com/mpv-player/mpv/releases"
  echo "v2rayn: https://github.com/2dust/v2rayN/releases"
  echo "qBittorent: https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases"
  echo "cracked app links:"
  echo "alfred: https://www.minorpatch.com/apps/alfred-powerpack.html"
  echo "pdf expert: https://www.minorpatch.com/apps/pdf-expert.html"
else
  #=========================
  #========  Arch  =========
  #=========================
  sudo pacman -Syu --noconfirm

  sudo pacman -S --needed --noconfirm base-devel curl git zip unzip trash-cli tree less
  sudo pacman -S --needed --noconfirm zsh fzf ripgrep fd the_silver_searcher fastfetch mandoc onefetch
  sudo pacman -S --needed --noconfirm neovim treesitter-cli yazi tmux lazygit git-delta
  sudo pacman -S --needed --noconfirm htop cmake make ninja gdb clang llvm lldb bear podman
  sudo pacman -S --needed --noconfirm imagemagick

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
fi

echo "done!"
