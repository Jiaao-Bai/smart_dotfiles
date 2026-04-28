# smart_dotfiles

个人开发环境配置。

## 内容

| 路径 | 用途 |
|---|---|
| `.config/nvim/` | Neovim 配置 |
| `.zshrc` | zsh 配置 |
| `.zsh_aliases` | shell 别名 |
| `.ctags.d/` | universal-ctags 全局配置（CUDA 语言映射） |
| `dockerfile/` | 开发容器镜像 |

## 安装

### Neovim

```bash
mkdir -p ~/.config
cp -r .config/nvim ~/.config/
```

插件由 lazy.nvim 管理，首次启动自动安装。

### zsh

```bash
cp .zshrc ~/.zshrc
cp .zsh_aliases ~/.zsh_aliases
echo "source ~/.zsh_aliases" >> ~/.zshrc
```

### ctags（C++/CUDA 项目跳转）

安装 universal-ctags：

```bash
# macOS
brew install universal-ctags

# Ubuntu
apt install universal-ctags
```

复制语言配置：

```bash
cp -r .ctags.d ~/.ctags.d
```

在每个 C++/CUDA 项目根目录执行一次，生成索引：

```bash
ctags -R .
echo "tags" >> .gitignore
```

### 终端

使用 [Ghostty](https://ghostty.org)。在 `~/.config/ghostty/config` 中设置字号：

```
font-size = 17
```

## Docker

```bash
# 1. 在宿主机安装好插件
nvim  # 进入后 :Lazy sync，可选 :Mason 和 :TSInstall

# 2. 导出插件目录
cp -r ~/.local/share/nvim dockerfile/

# 3. 构建
docker build --platform=linux/amd64 --network host \
  -f dockerfile/Dockerfile_pytorch_nvim_claude .
```
