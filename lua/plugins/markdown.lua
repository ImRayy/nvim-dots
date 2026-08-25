return {

  -- Improve viewing Markdown files in Neovim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "norg", "rmd", "org" },
    opts = {
      pipe_table = { cell = "trimmed" },
      heading = {
        position = "inline",
        width = "block",
        min_width = 30,
        border = false,
        above = "",
        below = "-",
        icons = { "󰼏 ", "󰼐 ", "󰼑 ", "󰼒 ", "󰼓 ", "󰼔 " },
        sign = false,
        backgrounds = { "" },
      },
      code = {
        sign = false,
        width = "block",
        min_width = 45,
        left_pad = 2,
        right_pad = 4,
      },
      checkbox = {
        unchecked = { icon = "✘" },
        checked = { icon = "󰸞" },
      },
    },
  },

  -- Obsidian 🤝 Neovim for writing and navigating obsidian vaults
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Notes/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Notes/*.md",
    },
    opts = {
      workspaces = {
        {
          name = "Universal",
          path = "~/Documents/Notes",
        },
      },
      templates = {
        folder = "Template",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
      ui = { enable = false },
    },
  },
}
