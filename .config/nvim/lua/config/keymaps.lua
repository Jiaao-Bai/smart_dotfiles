-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = {
  noremap = true, -- 键位映射是非递归的
  silent = true, -- 关闭映射触发时多余的信息
}

-- 本地变量
local map = vim.api.nvim_set_keymap

map("n", "<leader>w", ":w<CR>", opt)

-- 上下滚动浏览
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)
map("v", "<C-j>", "5j", opt)
map("v", "<C-k>", "5k", opt)

-- 复制到系统剪切板
map("v", "<C-y>", "\"+y", opt)

-- 插件快捷键
local pluginKeys = {}

-- nvim-tree
map("n", "<leader>m", ":NvimTreeToggle<CR>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<Tab>", ":BufferLineCycleNext<CR>", opt)
-- 关闭左/右侧buffer
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
-- 关闭其他buffer
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)
-- 关闭选中buffer
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opt)

-- 关闭当前 buffer，保持窗口不关（先跳到上一个 buffer，再删除刚才那个）
map("n", "<leader>q", ":bp<bar>bdelete #<CR>", opt)

-- LSP 快捷键由 Neovim 0.11+ 自动内置，无需手动配置：
--   K        悬浮文档    gd  跳转定义    gD  跳转声明
--   grn      重命名      gra 代码动作    grr 查看引用    gri 跳转实现
--   ]d / [d  诊断跳转    <C-W>d 显示诊断详情

-- Telescope
map("n", "<leader>p", ":Telescope find_files<CR>", opt)
map("n", "<leader>f", ":Telescope live_grep<CR>", opt)

-- gitsigns
map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", opt)
map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", opt)
map("n", "<leader>ghs", ":Gitsigns stage_hunk<CR>", opt)
map("v", "<leader>ghs", ":Gitsigns stage_hunk<CR>", opt)
map("n", "<leader>ghr", ":Gitsigns reset_hunk<CR>", opt)
map("v", "<leader>ghr", ":Gitsigns reset_hunk<CR>", opt)
map("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>", opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
  i = {
    -- 上下移动
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    -- 历史记录
    ["<Down>"] = "cycle_history_next",
    ["<Up>"] = "cycle_history_prev",
    -- 关闭窗口
    -- ["<esc>"] = actions.close,
    ["<C-c>"] = "close",
    -- 预览窗口上下滚动
    ["<C-u>"] = "preview_scrolling_up",
    ["<C-d>"] = "preview_scrolling_down",
  },
}

return pluginKeys
