return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Rainbow parentheses
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup()
    end,
  },

  -- Makes Commenting Easy
  {
    "numToStr/Comment.nvim",
    opts = {
      {},
    },
  },

  -- Autohighlight word under cursor
  {
    "echasnovski/mini.cursorword",
    branch = "stable",
    opts = {},
  },

  -- CSS color highlight
  {
    "NvChad/nvim-colorizer.lua",
    opts = {},
  },
}
