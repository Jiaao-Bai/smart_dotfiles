# smart_dotfiles

Neovim / zsh / Ghostty 个人配置，面向 macOS 日常开发与 CUDA 容器环境。

## 内容

| 路径 | 用途 |
|---|---|
| `.config/nvim/` | Neovim 配置 |
| `.config/ghostty/` | Ghostty 终端配置 |
| `.zsh_aliases` | shell 别名 |
| `.ctags.d/` | universal-ctags 全局配置（CUDA 语言映射） |
| `dockerfile/` | Linux 开发容器镜像 |

---

## macOS 新机器

**前置**：手动安装 [Ghostty](https://ghostty.org)、[Neovim](https://github.com/neovim/neovim/releases)、[universal-ctags](https://formulae.brew.sh/formula/universal-ctags)。

```bash
git clone https://github.com/Jiaao-Bai/smart_dotfiles.git
cd smart_dotfiles
./install.sh
```

`install.sh` 通过 symlink 链接配置文件，之后 `git pull` 即可同步更新。不会覆盖 `~/.zshrc`，只会在末尾追加一行 `source ~/.zsh_aliases`。

打开 nvim，依次执行：

```
:Lazy sync       " 安装所有插件（lazy.nvim 管理）
:Mason           " 安装 LSP server（当前：lua-language-server）
:TSInstall cpp cuda lua python bash   " 安装 treesitter 语法解析器
```

- **`:Lazy sync`**：下载并安装 `lazy.nvim` 声明的所有插件，包括补全、高亮、telescope 等。
- **`:Mason`**：安装 LSP server。LSP 提供跳转定义、补全、诊断等语义功能，需要独立的语言服务进程。
- **`:TSInstall`**：安装 treesitter 语法解析器，驱动语法高亮和代码折叠。按需安装用到的语言。

---

## Docker 镜像（Linux 开发环境）

插件在宿主机预构建后打入镜像，容器启动即用，无需联网安装。

```bash
# 1. 确保宿主机已完成上方 macOS 安装步骤（:Lazy sync / :Mason / :TSInstall）

# 2. 导出插件目录
cp -r ~/.local/share/nvim dockerfile/

# 3. 构建
docker build --platform=linux/amd64 --network host \
  -f dockerfile/Dockerfile_pytorch_nvim_claude .
```

---

## ctags 索引（C++/CUDA 项目）

在每个 C++/CUDA 项目根目录执行一次：

```bash
ctags -R .
echo "tags" >> .gitignore
```

之后用 `<C-]>` 跳转定义，`<leader>*` 全文搜索引用。符号变化后重新执行即可。
