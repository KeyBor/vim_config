-- 简化版 LSP 配置 (lua/plugins/config/lsp.lua)
local lsp = vim.lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set({ "n", "v" }, "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

-- 直接配置服务器（不使用 mason-lspconfig 的 setup_handlers）
local function setup_server(server_name, config)
  local ok, server_config = pcall(require, "lspconfig.server_configurations." .. server_name)
  if ok and server_config then
    lsp.start(vim.tbl_extend("force", {
      name = server_name,
      on_attach = on_attach,
      capabilities = capabilities,
    }, config or {}))
  end
end

-- 配置服务器
setup_server("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- 诊断配置
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.notify("LSP configuration loaded (simplified)")

