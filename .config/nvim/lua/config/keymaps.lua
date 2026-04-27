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

-- 系统剪贴板：<C-y> 复制，<C-p> 粘贴
map("v", "<C-y>", "\"+y", opt)
map("n", "<C-p>", "\"+p", opt)

-- 插件快捷键
local pluginKeys = {}

-- nvim-tree
map("n", "<leader>m", ":NvimTreeToggle<CR>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<Tab>", ":BufferLineCycleNext<CR>", opt)
-- 关闭其他buffer
map("n", "<leader>bo", ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>", opt)
-- 字母选择跳转 buffer
map("n", "<leader>bb", ":BufferLinePick<CR>", opt)
-- 字母选择关闭 buffer
map("n", "<leader>bp", ":BufferLinePickClose<CR>", opt)

-- 关闭当前 buffer，保持窗口不关（先跳到上一个 buffer，再删除刚才那个）
map("n", "<leader>q", ":bp<bar>bdelete #<CR>", opt)

-- ctags + ripgrep 跳转
vim.keymap.set("n", "<C-]>", function()
  require("telescope.builtin").tags({ default_text = vim.fn.expand("<cword>") })
end, { noremap = true, silent = true, desc = "跳转定义 (ctags)" })

vim.keymap.set("n", "<leader>*", function()
  require("telescope.builtin").grep_string()
end, { noremap = true, silent = true, desc = "搜索引用 (ripgrep)" })

-- LSP 快捷键由 Neovim 0.11+ 在 LspAttach 时自动设置为 buffer-local（优先级高于上方全局映射）：
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

-- Comment.nvim
--   gcc       行注释 toggle
--   gbc       块注释 toggle
--   gc<动作>  注释范围，如 gc3j 注释下面3行
pluginKeys.comment = {
  toggler = {
    line  = "gcc",
    block = "gbc",
  },
  opleader = {
    line  = "gc",
    block = "gb",
  },
}
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
