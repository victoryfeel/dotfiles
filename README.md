# Deploy configs with one single command

## For Personal Computer

```bash
curl -fsSL https://raw.githubusercontent.com/victoryfeel/dotfiles/main/bin/boom.sh | bash
```

## For Company Computer

```bash
git clone --depth 1 https://github.com/victoryfeel/dotfiles.git ~/.dotfiles && bash ~/.dotfiles/bin/boom.sh
```

# A-neovim

backup first if you copy my nvim configs

- mv ~/.config/nvim{,.bak}
- mv ~/.local/share/nvim{,.bak}
- mv ~/.local/state/nvim{,.bak}
- mv ~/.cache/nvim{,.bak}
