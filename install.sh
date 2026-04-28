#!/bin/bash
# macOS 配置安装脚本
# 用 symlink 链接配置文件，git pull 即可同步更新
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ~/.config/* — 每个子目录单独 symlink，不整体替换 ~/.config
mkdir -p ~/.config
for dir in "$DOTFILES"/.config/*/; do
  name=$(basename "$dir")
  ln -sfn "$dir" ~/.config/"$name"
  echo "linked ~/.config/$name"
done

# ctags 语言映射
ln -sfn "$DOTFILES/.ctags.d" ~/.ctags.d && echo "linked ~/.ctags.d"

# zsh aliases — symlink 文件，然后往现有 .zshrc 追加 source 行（幂等）
ln -sf "$DOTFILES/.zsh_aliases" ~/.zsh_aliases && echo "linked ~/.zsh_aliases"
if ! grep -q "source ~/.zsh_aliases" ~/.zshrc 2>/dev/null; then
  echo "source ~/.zsh_aliases" >> ~/.zshrc
  echo "added 'source ~/.zsh_aliases' to ~/.zshrc"
fi

echo
echo "done. restart your shell to apply zsh changes."
