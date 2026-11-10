#!/usr/bin/env bash
set -e

echo "[packages.sh] Installing packages..."

if [ "$(uname -s)" = "Darwin" ]; then
  #========================
  #========  Mac  =========
  #========================
  eval "$(/opt/homebrew/bin/brew shellenv)"

  xcode-select --install
  brew install git git-delta tree trash-cli tree-sitter-cli
  brew install fzf ripgrep fd the_silver_searcher
  brew install mandoc fastfetch imagemagick newsboat neomutt
  brew install tmux neovim lazygit yazi
  brew install node python googletest htop
  brew install go gopls golangci-lint
  brew install rust && rustup-init
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

  sudo pacman -S --needed --noconfirm base-devel curl git git-delta zip unzip trash-cli tree tree-sitter-cli less
  sudo pacman -S --needed --noconfirm zsh fzf ripgrep fd the_silver_searcher
  sudo pacman -S --needed --noconfirm mandoc fastfetch imagemagick newsboat neomutt
  sudo pacman -S --needed --noconfirm tmux neovim lazygit yazi
  sudo pacman -S --needed --noconfirm npm nodejs python-pip gtest htop
  sudo pacman -S --needed docker docker-compose docker-buildx
  sudo systemctl enable --now docker && sudo usermod -aG docker $USER
  sudo pacman -S --needed --noconfirm clang cmake make ninja gdb llvm lldb bear boost
  sudo pacman -S --needed --noconfirm go gopls golangci-lint
  sudo pacman -S --needed --noconfirm rustup

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
