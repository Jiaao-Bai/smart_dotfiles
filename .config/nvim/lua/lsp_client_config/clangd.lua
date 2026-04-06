vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',         -- 后台建索引，cutlass 这类大型模板库必须开启
    '--clang-tidy',               -- 启用静态检查
    '--header-insertion=never',   -- 不自动插入头文件（模板代码中容易误插）
    '--completion-style=detailed',-- 补全时显示详细类型信息
    '--function-arg-placeholders',-- 补全函数时填充参数占位符
  },
  -- 显式声明支持 cuda 文件类型（.cu / .cuh）
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  root_markers = {
    'compile_commands.json', -- CMake 生成，clangd 读取编译参数的首选方式
    '.clangd',               -- clangd 配置文件
    'CMakeLists.txt',
    'compile_flags.txt',
    '.git',
  },
})

vim.lsp.enable('clangd')
