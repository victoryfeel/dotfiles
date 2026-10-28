#!/usr/bin/env bash
set -e

echo "[packages.sh] Installing packages..."

if [ "$(uname -s)" = "Darwin" ]; then
  #========================
  #========  Mac  =========
  #========================
  eval "$(/opt/homebrew/bin/brew shellenv)"

  brew install git git-delta fzf fd ripgrep trash-cli
  brew install lazygit neovim yazi tmux
  brew install imagemagick neomutt newsboat
  brew install rust go node
  brew install --cask kitty orbstack dbeaver-community antigravity-cli
  brew install --cask freefilesync google-drive cryptomator helium-browser
  brew install --cask anki calibre

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
  sudo pacman -S --needed --noconfirm neovim tree-sitter-cli yazi tmux lazygit git-delta
  sudo pacman -S --needed --noconfirm zsh fzf ripgrep fd the_silver_searcher fastfetch mandoc
  sudo pacman -S --needed --noconfirm imagemagick
  sudo pacman -S --needed --noconfirm htop podman
  sudo pacman -S --needed --noconfirm rust go npm nodejs
  sudo pacman -S --needed --noconfirm boost cmake make ninja gdb clang llvm lldb bear

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

echo "[packages.sh] Finished."
