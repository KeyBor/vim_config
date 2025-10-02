local M = {}

function M.theme()
  -- Solarized Light 配置
  vim.g.solarized_italics = 1
  vim.g.solarized_contrast = "normal"
  vim.g.solarized_visibility = "normal"
  vim.g.solarized_diffmode = "normal"
  vim.g.solarized_termtrans = 1  -- 让终端背景透明，更一体化
  
  -- 应用主题
  vim.cmd.colorscheme("solarized")
  vim.o.background = "light"
  
  -- 增强一体性的颜色调整
  vim.api.nvim_set_hl(0, "Normal", { bg = "#fdf6e3" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#93a1a1", bg = "#fdf6e3" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#657b83", bg = "#eee8d5", bold = true })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "#fdf6e3" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#eee8d5" })
  
  -- 浮动窗口和弹窗背景
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#93a1a1", bg = "#fdf6e3" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#fdf6e3" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "#eee8d5" })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#859900", fg = "#fdf6e3" })
end

function M.nvim_tree()
  require("nvim-tree").setup({
    view = {
      width = 35,
      relativenumber = true,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      icons = {
        show = {
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
      indent_markers = {
        enable = true,
      },
    },
    filters = {
      dotfiles = false,
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 500,
    },
  })
  
  vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
end

function M.lualine()
  require("lualine").setup({
    options = {
      theme = "solarized_light",
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { "NvimTree" },
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
    extensions = { 'nvim-tree' },
  })
end

return M

