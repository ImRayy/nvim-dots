return {
  -- WhichKey : Shows keybindings
  {
    "folke/which-key.nvim",
    lazy = true,
    opts = {},
  },

  -- Noice: Command UI
  {
    "folke/noice.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        inc_rename = true,
        bottom_search = true,
        command_palette = true,
      },
    },
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        component_separators = "",
        section_separators = "",
        icons_enabled = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          { "mode", color = { gui = "bold" } },
        },
        lualine_b = {
          { "branch" },
          { "diff", colored = false },
        },
        lualine_c = {
          { "filename", file_status = true },
          { "diagnostics" },
        },
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
          },
          "filetype",
        },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
      tabline = {},
      extensions = { "quickfix", "nvim-tree" },
    },
  },
}
