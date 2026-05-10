local status, aerial = pcall(require, "aerial")
if not status then
  vim.notify("没有找到 aerial")
  return
end

aerial.setup({
  backends = { "treesitter", "lsp" },
  -- 侧边栏 buffer-local 快捷键（与全局 <C-j>/<C-k>=5j/5k 保持一致）
  keymaps = {
    ["<C-j>"] = function() vim.cmd("normal! 5j") end,
    ["<C-k>"] = function() vim.cmd("normal! 5k") end,
  },
  -- 只显示有意义的符号，过滤掉变量/字段/参数
  filter_kind = {
    "Class", "Constructor", "Enum", "EnumMember",
    "Function", "Interface", "Method", "Module",
    "Namespace", "Struct", "TypeAlias",
  },
  layout = {
    max_width = { 40, 0.2 },
    min_width = 25,
    default_direction = "right",
  },
  -- 跳转后自动关闭 aerial 侧边栏
  close_on_select = false,
  -- 光标移动时在侧边栏中高亮当前符号
  highlight_on_hover = true,
})

-- 注册 telescope 扩展
pcall(require("telescope").load_extension, "aerial")
