return {
  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    opts = {
      options = {
        enable_close_on_slash = true,
      },
    },
  },

  -- Indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "LspAttach",
    commit = "*",
    opts = {
      scope = {
        enabled = false,
      },
      exclude = {
        buftypes = { "terminal" },
      },
      indent = {
        char = "│",
        tab_char = { "." },
      },
    },
  },

  -- Navigate your code with search labels, enhanced character motions
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
        -- stylua: ignore
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
  },

  -- Find Nerd Glyphs Easily 🤓🔭
  {
    "2kabhishek/nerdy.nvim",
    cmd = "Nerdy",
    lazy = true,
  },

  -- Incremental LSP renaming based on Neoviml's command-preview feature
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    lazy = true,
    keys = {
      { "<leader>rn", ":IncRename ", mode = "n" },
    },
    config = function()
      require("inc_rename").setup()
    end,
  },

  -- SQL stuff
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = { "tpope/vim-dadbod" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      { "<leader>d", "<cmd>tabnew<cr><cmd>DBUI<cr>", mode = "n" },
      { "<a-d>", "<cmd>DBUIToggle<cr><cmd>Neotree close<cr>", mode = "n" },
    },
  },

  -- Dims inactive portions of the code you're editing using TreeSitter.
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    lazy = true,
    dependencies = { "folke/twilight.nvim" },
    opts = {
      plugins = {
        kitty = {
          enabled = true,
          font = "+2",
        },
        neovide = {
          enabled = true,
          scale = 1.2,
          disable_animations = {
            neovide_animation_length = 0.15,
            neovide_cursor_animate_command_line = true,
            neovide_scroll_animation_length = 0.3,
            neovide_position_animation_length = 0.15,
            neovide_cursor_animation_length = 0.12,
            neovide_cursor_vfx_mode = "ripple",
          },
        },
      },
    },
  },

  -- Handful of tweaks needed to smooth the path to writing prose
  {
    "preservim/vim-pencil",
    cmd = "Pencil",
    config = function() end,
  },
}
