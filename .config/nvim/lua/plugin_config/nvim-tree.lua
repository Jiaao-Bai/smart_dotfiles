local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("没有找到 nvim-tree")
  return
end

nvim_tree.setup({
  -- 恢复 nvim-tree 内 <C-j>/<C-k> 为单步导航，避免与全局 5j/5k 冲突
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)
    local opt = { buffer = bufnr, silent = true }
    vim.keymap.set("n", "<C-j>", "j", opt)
    vim.keymap.set("n", "<C-k>", "k", opt)
  end,
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    -- 宽度
    width = 30,
    -- 也可以 'right'
    side = "left",
    -- 不显示行数
    number = false,
    relativenumber = false,
    -- 显示图标
    signcolumn = "yes",
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    -- 隐藏 .文件
    dotfiles = false,
  },
  -- 切换 buffer 时自动在树中展开并高亮当前文件
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  -- 显示 git 状态图标
  git = {
    enable = true,
  },
  actions = {
    open_file = {
      -- 首次打开大小适配
      resize_window = true,
      -- 打开文件时关闭 tree
      quit_on_open = false,
    },
  },
  system_open = {
    cmd = "open",
  },
})