#!/usr/bin/env bash
set -e

echo "[configsys.sh] Config system..."

if [ "$SHELL" != "$(which zsh)" ]; then
  sudo chsh -s "$(which zsh)" "$USER" || true
fi
mkdir -p "$HOME/alexmak/dev_learn"
mkdir -p "$HOME/alexmak/dev_ongo"
mkdir -p "$HOME/alexmak/tmp"

git config --global user.name "Alex Mak"
git config --global user.email "113433667+victoryfeel@users.noreply.github.com"
git config --global init.defaultBranch main
git config --global core.fsync all
git config --global core.fsyncMethod fsync

# systemctl --user enable --now podman.socket

## ============================== ##
## ========  os_settings  ======= ##
## ============================== ##
if [ "$(uname -s)" = "Linux" ]; then
  DOTFILES="$HOME/alexmak/dotfiles"

  # keyd: copy (not symlink) so root-read config does not depend on $HOME
  sudo install -Dm644 "$DOTFILES/os_settings/keyd-map.conf" /etc/keyd/default.conf
  sudo systemctl enable --now keyd
  sudo keyd reload || true
fi

echo "[configsys.sh] Finished."
