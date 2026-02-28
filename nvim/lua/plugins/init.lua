return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc", "printf", "luadoc",
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
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    opts = {
      extensions_list = { "themes", "terms", "fzf" },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
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
        "prettier",
        "stylua",
        "black",
        "isort",
        "shfmt",
      },
    },
  },
}
