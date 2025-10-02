local M = {}

function M.treesitter()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { 
      "lua", "python", "bash", "json", "yaml", "markdown", 
      "javascript", "typescript", "html", "css", "rust", "go","c","cpp"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  })
end

-- 添加额外的颜色增强
function M.enhance_colors()
  -- 更柔和的搜索高亮
  vim.api.nvim_set_hl(0, "Search", { bg = "#b58900", fg = "#fdf6e3" })
  vim.api.nvim_set_hl(0, "IncSearch", { bg = "#d33682", fg = "#fdf6e3" })
  
  -- 视觉模式选择
  vim.api.nvim_set_hl(0, "Visual", { bg = "#eee8d5" })
  
  -- 注释更柔和
  vim.api.nvim_set_hl(0, "Comment", { fg = "#839496", italic = true })
  
  -- 光标行
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "#eee8d5" })
  
  -- 状态行
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "#eee8d5", fg = "#657b83" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#fdf6e3", fg = "#93a1a1" })
end

return M

