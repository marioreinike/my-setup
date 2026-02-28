return {
  base46 = {
    theme = "onedark",
    hl_override = {},
    hl_add = {},
    transparency = false,
  },

  nvdash = {
    load_on_startup = true,
  },

  ui = {
    cmp = {
      icons_left = false,
      lspkind_text = true,
      style = "default",
    },

    telescope = { style = "borderless" },

    statusline = {
      theme = "default",
      separator_style = "default",
    },

    tabufline = {
      enabled = true,
      lazyload = true,
    },
  },

  lsp = { signature = true },

  cheatsheet = {
    theme = "grid",
  },

  mason = { pkgs = {} },
}
