pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

return {
  ensure_installed = {
    "lua", "luadoc", "printf", "vim", "vimdoc",
    "typescript", "tsx", "javascript", "jsdoc",
    "python",
    "json", "jsonc", "yaml", "toml",
    "html", "css",
    "bash",
    "terraform", "hcl",
    "markdown", "markdown_inline",
    "dockerfile",
    "gitcommit", "gitignore", "diff",
    "regex",
  },
}
