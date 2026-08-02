#!/usr/bin/env bash
set -e

if [ "$(uname -s)" = "Darwin" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install git curl
else
  sudo pacman -S --needed --noconfirm git curl
fi

TARGET_DIR="$HOME/alexmak/dotfiles"

if [ -d "$TARGET_DIR/.git" ]; then
  git -C "$TARGET_DIR" pull
else
  mkdir -p "$(dirname "$TARGET_DIR")"
  git clone https://github.com/victoryfeel/dotfiles.git "$TARGET_DIR"
fi

bash "$TARGET_DIR/bin/packages.sh"
bash "$TARGET_DIR/bin/configsys.sh"
bash "$TARGET_DIR/bin/link.sh"

if [ -t 0 ]; then
  exec zsh
fi
