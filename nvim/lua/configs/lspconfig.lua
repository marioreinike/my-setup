require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ts_ls",
  "pyright",
  "terraformls",
  "bashls",
  "jsonls",
  "yamlls",
  "tailwindcss",
}

vim.lsp.enable(servers)
