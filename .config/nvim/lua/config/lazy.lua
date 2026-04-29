-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- 界面
  -- vscode colorscheme
  "Mofiqul/vscode.nvim",
  -- nvim-tree
  {"nvim-tree/nvim-tree.lua", version = "*", lazy = false, dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup {}
    end,},
  -- bufferline
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  -- lualine
  {"nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }},
  "arkav/lualine-lsp-progress",
  -- telescope
  {"nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }},
  -- gitsigns
  {"lewis6991/gitsigns.nvim", dependencies = "nvim-lua/plenary.nvim"},

  -- 代码部分
  -- Comment代码注释
  {"numToStr/Comment.nvim"},
  -- treesitter代码高亮, 缩进，折叠等
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- lsp
  -- 包管理器 for lsp server, dap server, etc.
  { "mason-org/mason.nvim", opts = {} },

  -- nvim内置lsp client对lsp server的官方版配置
  -- nvim-lspconfig is a "data only" repo, providing basic, default Nvim LSP client configurations
  { "neovim/nvim-lspconfig" },

  -- 代码补全
  -- blink.compat：让 nvim-cmp 的 source 能在 blink.cmp 中使用
  { "saghen/blink.compat", version = "*" },
  -- ctags 补全源（通过 blink.compat 接入）
  { "quangnguyen30192/cmp-nvim-tags" },
  {
    "saghen/blink.cmp",
    version = "*",
    config = function()
      require('blink.cmp').setup({
        -- 键位映射：基于 default 预设，禁用 Tab/S-Tab 以保留 insert 模式原生缩进
        --   <C-Space> 手动触发补全
        --   <C-n>/<C-p> 上下选择（nvim 原生补全键）
        --   <CR> 确认补全，<C-e> 关闭补全窗口
        keymap = {
          preset = "default",
          ['<Tab>'] = {},
          ['<S-Tab>'] = {},
          ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = {
          nerd_font_variant = "mono",
        },
        completion = {
          list = {
            -- 弹出时自动选中第一项，<CR> 可直接确认
            selection = { preselect = true, auto_insert = false },
          },
        },
        sources = {
          -- 补全来源：LSP语义补全、文件路径、所有已加载的 buffer、ctags 索引
          default = { "lsp", "path", "buffer", "tags" },
          providers = {
            buffer = {
              opts = {
                -- 默认只搜当前 buffer，改为搜所有已加载的 buffer
                get_bufnrs = vim.api.nvim_list_bufs,
              },
            },
            -- ctags 补全：读取项目根目录的 tags 文件，覆盖未打开的文件中的符号
            -- 使用前需在项目根目录执行 ctags -R .
            tags = {
              name = "tags",
              module = "blink.compat.source",
            },
          },
        },
        -- 显示函数参数签名提示
        signature = { enabled = true },
      })
      -- 将 blink.cmp 支持的补全能力注入到所有 LSP server 的握手中
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities()
      })
    end,
  },
})
