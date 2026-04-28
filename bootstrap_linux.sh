#!/bin/bash
# Linux 服务器依赖安装脚本
# 安装 nvim + 导航工具，然后运行 ./install.sh 链接配置文件
set -e

NVIM_VERSION="v0.11.6"

echo "==> 安装系统依赖..."
apt-get update && apt-get install -y --no-install-recommends \
  wget git ca-certificates build-essential \
  ripgrep fd-find universal-ctags xclip \
  && update-ca-certificates \
  && rm -rf /var/lib/apt/lists/*

echo "==> 安装 nvim ${NVIM_VERSION}..."
wget --no-check-certificate \
  "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"
tar -zxf nvim-linux-x86_64.tar.gz
cp -r nvim-linux-x86_64/* /usr/local/
rm -rf nvim-linux-x86_64 nvim-linux-x86_64.tar.gz

echo "==> 链接配置文件..."
"$(dirname "${BASH_SOURCE[0]}")/install.sh"

echo
echo "done. 打开 nvim 运行 :Lazy sync 安装插件。"
echo "如需离线插件，将宿主机 ~/.local/share/nvim 目录 scp 到 ~/.local/share/nvim 后跳过上一步。"
