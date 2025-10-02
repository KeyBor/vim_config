local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- 默认映射不需要修改，只需要添加额外功能
  vim.keymap.set('n', '<C-e>', api.tree.toggle, opts('Toggle Tree'))
  vim.keymap.set('n', '<leader>e', api.tree.toggle, opts('Toggle Tree'))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  sort_by = "case_sensitive",
  view = {
    width = 35,
    relativenumber = true,
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 40,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
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
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})

-- 快捷键
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>', { desc = 'Find current file in tree' })
vim.keymap.set('n', '<leader>er', ':NvimTreeRefresh<CR>', { desc = 'Refresh file tree' })

