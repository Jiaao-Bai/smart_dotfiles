# smart_dotfiles

生存装备库（macOS）。

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

前置：手动安装 [Ghostty](https://ghostty.org)、[Neovim](https://github.com/neovim/neovim/releases)、[universal-ctags](https://formulae.brew.sh/formula/universal-ctags)。

```bash
git clone https://github.com/Jiaao-Bai/smart_dotfiles.git
cd smart_dotfiles
./install.sh
```

`install.sh` 通过 symlink 链接配置文件，之后 `git pull` 即可同步更新。不会覆盖 `~/.zshrc`，只会在末尾追加一行 `source ~/.zsh_aliases`。

打开 nvim，执行 `:Lazy sync` 安装插件。

---

## Docker 镜像（Linux 开发环境）

插件在宿主机预构建后打入镜像，容器启动即用。

```bash
# 1. 在宿主机安装好插件（:Lazy sync，可选 :Mason 和 :TSInstall）

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
