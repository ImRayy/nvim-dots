return {
  -- Rainbow parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup()
    end,
  },

  -- Tiny plugin to enhance Neovim's native comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Color highlight
  {
    "catgoose/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        css = true,
        mode = "virtualtext",
        virtualtext = "",
        virtualtext_inline = "before",
        names = false,
      },
      filetypes = {
        "*",
        "!prompt",
        "!popup",
        html = { mode = "foreground" },
        cmp_docs = { always_update = true },
        css = { names = true },
      },
    },
  },

  -- Highlight, list and search todo comments in your projects
  { "folke/todo-comments.nvim", event = "LspAttach", opts = {} },

  -- 🚦 Trouble: A pretty diagnostics, references, telescope results, quickfix
  -- and location list to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
