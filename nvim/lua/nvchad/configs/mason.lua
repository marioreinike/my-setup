dofile(vim.g.base46_cache .. "mason")

return {
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },

  max_concurrent_installers = 10,

  ensure_installed = {
    -- LSP servers
    "lua-language-server",
    "typescript-language-server",
    "pyright",
    "terraform-ls",
    "bash-language-server",
    "json-lsp",
    "yaml-language-server",
    "css-lsp",
    "html-lsp",
    "tailwindcss-language-server",

    -- Formatters
    "prettier",
    "stylua",
    "black",
    "isort",
    "shfmt",
  },
}
