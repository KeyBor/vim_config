local M = {}

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local builtin = require("telescope.builtin")

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<Esc>"] = actions.close,
        },
      },
      file_ignore_patterns = {
        "node_modules", ".git", "target", "build"
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
      },
      live_grep = {
        theme = "dropdown",
      },
    },
  })

    -- 当前文件的函数
    vim.keymap.set("n", "<leader>ff", function()
      builtin.lsp_document_symbols({
        symbols = { "function", "method" }
      })
    end, { desc = "Find Functions" })
    
    -- 当前文件的所有符号（类、函数、变量等）
    vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
    
    -- 整个项目的函数
    vim.keymap.set("n", "<leader>fw", function()
      builtin.lsp_workspace_symbols({
        symbols = { "function", "method", "class" }
      })
    end, { desc = "Find Workspace Functions" })
    
    -- 使用 treesitter 查找（不需要 LSP）
    vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Find Treesitter Symbols" })    
end

return M

