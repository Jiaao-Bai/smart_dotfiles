# CLAUDE.md

AI 助手工作指南。

## 仓库结构

```
├── .config/nvim/
│   ├── init.lua                    # 入口，require 各模块
│   ├── lazy-lock.json              # 插件版本锁文件
│   ├── lua/config/
│   │   ├── options.lua             # vim 选项
│   │   ├── keymaps.lua             # 所有快捷键（唯一定义处）
│   │   └── lazy.lua                # 插件声明 + 内联配置
│   ├── lua/plugin_config/          # 各插件独立配置文件
│   └── lua/lsp_client_config/      # LSP server 配置
├── .zshrc                          # zsh 配置
├── .zsh_aliases                    # shell 别名
├── .ctags.d/cuda.ctags             # universal-ctags CUDA 语言映射
└── dockerfile/
    └── Dockerfile_pytorch_nvim_claude  # NVIDIA PyTorch + nvim + Claude Code
```

## Neovim 配置

### 插件管理

使用 lazy.nvim。插件声明在 `lua/config/lazy.lua`，部分插件的简单配置直接内联在声明里（如 blink.cmp），复杂配置单独放在 `lua/plugin_config/`。

### 主要插件

- **UI**: vscode.nvim（配色）、nvim-tree（文件树）、bufferline（标签栏）、lualine（状态栏）
- **导航**: telescope.nvim（模糊搜索，底层用 ripgrep）
- **编辑**: Comment.nvim、nvim-treesitter（高亮/缩进/折叠）
- **补全**: blink.cmp（来源：LSP + 路径 + buffer）
- **LSP**: mason.nvim（工具安装器）、nvim-lspconfig

### LSP 配置

使用 Neovim 0.11+ 原生 API（`vim.lsp.config()` + `vim.lsp.enable()`）。

当前配置的 LSP server：
- `lua/lsp_client_config/luals.lua` — lua-language-server，仅用于 `.lua` 文件

C++/CUDA 项目不使用 LSP，改用 ctags + telescope 方案（见下）。

### C++/CUDA 项目导航

使用 universal-ctags + telescope 替代 clangd：
- `<C-]>` — telescope tags，跳转到光标下符号的定义（ctags 索引）
- `<leader>*` — telescope grep_string，全文搜索光标下单词（ripgrep）

使用前需在项目根目录执行 `ctags -R .` 生成索引文件。

### 快捷键规则

**所有快捷键必须定义在 `lua/config/keymaps.lua`**，plugin config 文件不得自行定义快捷键。

Neovim 0.11+ 在 `LspAttach` 时自动设置 buffer-local LSP 快捷键（`gd`、`grr` 等），优先级高于 keymaps.lua 中的全局映射。C++/CUDA 文件无 LSP 附加，走全局映射（ctags/rg）。

### VS Code 支持

检测 `vim.g.vscode` 后加载 `lua/config/keymaps_vscode.lua`，仅启用最小化快捷键。

## zsh 配置

别名定义在 `.zsh_aliases`（由 `.zshrc` source）：
- Git: `gs` `gr` `gl` `gc`
- ls: `ll` `la` `l`
- Editor: `v`（nvim）

## 注意事项

- 配置文件中有中文注释，保持现有风格
- 更新插件需修改 `lazy-lock.json`
- `.zshrc` 中有硬编码路径 `/Users/baijiaao/.openclaw/completions/openclaw.zsh`，在其他机器上会报错，可忽略
