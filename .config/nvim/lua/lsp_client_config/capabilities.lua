-- 为所有 LSP 服务器注入 blink.cmp 的补全能力
-- 这样 LSP 就能向补全引擎提供语义补全（变量、函数、类型等）
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities()
})
