local status = pcall(require, "gutentags")
-- vim-gutentags 是 vim 插件，通过 g: 变量配置，无 require API

-- 以 .git / CMakeLists.txt 作为项目根标记
vim.g.gutentags_project_root = {'.git', 'CMakeLists.txt'}

-- tags 文件名（存放在 cache_dir，不写入项目）
vim.g.gutentags_ctags_tagfile = '.tags'

-- ctags 额外参数：索引 C++ 的声明、原型、模板等
vim.g.gutentags_ctags_extra_args = {
  '--tag-relative=yes',
  '--fields=+ailmnS',
  '--c++-kinds=+px',   -- +p 函数原型  +x 外部变量声明
  '--extras=+qf',      -- +q 限定名称  +f 文件入口
}

-- tags 缓存统一放到 ~/.cache/nvim/tags，不污染项目目录
local cache_dir = vim.fn.expand('~/.cache/nvim/tags')
vim.fn.mkdir(cache_dir, 'p')
vim.g.gutentags_cache_dir = cache_dir

vim.g.gutentags_generate_on_new     = 1
vim.g.gutentags_generate_on_missing = 1
vim.g.gutentags_generate_on_write   = 1
vim.g.gutentags_generate_on_empty_buffer = 0
