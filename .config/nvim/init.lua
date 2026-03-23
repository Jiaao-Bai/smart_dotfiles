if vim.g.vscode then
    require("config.keymaps_vscode")
else
    -- 基础配置
    require("config.options")
    -- 快捷键映射
    require("config.keymaps")
    -- Packer插件管理
    require("config.lazy")

    -- -- 插件配置
    require("plugin_config.colorscheme")
    require("plugin_config.nvim-tree")
    require("plugin_config.bufferline")
    require("plugin_config.lualine")
    require("plugin_config.telescope")
    require("plugin_config.comment")
    require("plugin_config.nvim-treesitter")

    -- -- lsp client配置
    require("lsp_client_config.luals")
    require("lsp_client_config.clangd")
end



