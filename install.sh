#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ~/.config/* — 每个子目录单独 symlink，不整体替换 ~/.config
mkdir -p ~/.config
for dir in "$DOTFILES"/.config/*/; do
  name=$(basename "$dir")
  ln -sfn "$dir" ~/.config/"$name"
  echo "linked ~/.config/$name"
done

# home dotfiles
ln -sf "$DOTFILES/.zshrc"    ~/.zshrc    && echo "linked ~/.zshrc"
ln -sf "$DOTFILES/.zsh_aliases" ~/.zsh_aliases && echo "linked ~/.zsh_aliases"
ln -sfn "$DOTFILES/.ctags.d" ~/.ctags.d  && echo "linked ~/.ctags.d"

echo
echo "done. restart your shell to apply zsh changes."
