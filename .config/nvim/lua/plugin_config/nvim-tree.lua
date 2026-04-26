local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("没有找到 nvim-tree")
  return
end

nvim_tree.setup({
  -- 将 nvim-tree 默认的 <C-k>（文件信息）移到 K，与全局 5k 不冲突
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)
    local opt = { buffer = bufnr, silent = true }
    vim.keymap.del("n", "<C-k>", { buffer = bufnr })
    vim.keymap.set("n", "K", api.node.show_info_popup, opt)
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