#!/bin/bash
# Linux 配置安装脚本
# 仅链接 nvim 配置，并将 zsh aliases 追加到 ~/.bashrc
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 安全链接：目标已是软链则覆盖，是真实目录/文件则先备份再链接
link_safe() {
  local src="$1"
  local dst="$2"
  if [ -L "$dst" ]; then
    ln -sfn "$src" "$dst" && echo "linked $dst"
  elif [ -e "$dst" ]; then
    local bak="${dst}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$bak"
    echo "backed up $dst → $bak"
    ln -sfn "$src" "$dst" && echo "linked $dst"
  else
    ln -sfn "$src" "$dst" && echo "linked $dst"
  fi
}

mkdir -p ~/.config

# --- nvim 配置 ---
link_safe "$DOTFILES/.config/nvim" ~/.config/nvim

# --- zsh aliases → ~/.bashrc ---
MARKER="# >>> smart_dotfiles aliases >>>"
ALIASES_FILE="$DOTFILES/.zsh_aliases"

if grep -qF "$MARKER" ~/.bashrc 2>/dev/null; then
    echo "aliases already in ~/.bashrc, skipping"
else
    {
        echo ""
        echo "$MARKER"
        cat "$ALIASES_FILE"
        echo "# <<< smart_dotfiles aliases <<<"
    } >> ~/.bashrc
    echo "appended aliases to ~/.bashrc"
fi

echo
echo "done. run 'exec bash' or open a new terminal."
